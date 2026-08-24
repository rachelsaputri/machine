import { DependencyGraph, DependencyNode } from './DependencyAnalyzer';
import * as fs from 'fs';

export interface CompliancePolicy {
  id: string;
  name: string;
  condition: (node: DependencyNode, graph: DependencyGraph) => boolean;
  severity: 'critical' | 'high' | 'medium' | 'low';
}

export interface Violation {
  policyId: string;
  nodeName: string;
  message: string;
  severity: string;
}

export class PolicyValidator {
  private policies: CompliancePolicy[] = [];

  public loadPolicies(policyFilePath: string): void {
    const raw = fs.readFileSync(policyFilePath, 'utf-8');
    const policies = JSON.parse(raw) as Omit<CompliancePolicy, 'condition'>[];
    this.policies = policies.map(p => ({
      ...p,
      condition: this.compileCondition(p.condition as string),
    }));
  }

  private compileCondition(conditionStr: string): (node: DependencyNode, graph: DependencyGraph) => boolean {
    return new Function('node', 'graph', `return ${conditionStr};`) as any;
  }

  public validate(graph: DependencyGraph): Violation[] {
    const violations: Violation[] = [];
    graph.nodes.forEach((node, nodeId) => {
      for (const policy of this.policies) {
        try {
          const result = policy.condition(node, graph);
          if (!result) {
            violations.push({
              policyId: policy.id,
              nodeName: nodeId,
              message: `Policy '${policy.name}' violated for node '${nodeId}'`,
              severity: policy.severity,
            });
          }
        } catch (error) {
          violations.push({
            policyId: policy.id,
            nodeName: nodeId,
            message: `Condition evaluation failed for node '${nodeId}': ${error.message}`,
            severity: 'high',
          });
        }
      }
    });
    return violations;
  }

  public generateComplianceReport(violations: Violation[]): string {
    let report = '=== Compliance Audit Report ===\n\n';
    report += `Total Policies Checked: ${this.policies.length}\n`;
    report += `Total Violations Found: ${violations.length}\n\n`;

    if (violations.length === 0) {
      report += 'Status: FULLY COMPLIANT\n';
    } else {
      report += 'Status: NON-COMPLIANT\n\n';
      report += 'Violations:\n';
      violations.forEach(v => {
        report += `[${v.severity.toUpperCase()}] ${v.policyId}: ${v.message}\n`;
      });
    }

    return report;
  }
}
