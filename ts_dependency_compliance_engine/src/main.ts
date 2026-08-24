import { DependencyAnalyzer } from './DependencyAnalyzer';
import { PolicyValidator } from './PolicyValidator';
import * as fs from 'fs';
import * as path from 'path';

async function run() {
  const targetDir = process.argv[2] || '.';
  const policyPath = process.argv[3] || path.join(process.cwd(), 'policies.json');

  console.log(`[INIT] Starting analysis on directory: ${targetDir}`);
  console.log(`[INIT] Loading policies from: ${policyPath}`);

  const analyzer = new DependencyAnalyzer();
  const graph = await analyzer.analyzeDirectory(targetDir);
  console.log(`[ANALYSIS] Completed dependency mapping. Nodes: ${graph.nodes.size}`);

  console.log(`[VALIDATION] Starting policy enforcement...`);
  const validator = new PolicyValidator();
  validator.loadPolicies(policyPath);

  const violations = validator.validate(graph);
  const complianceReport = validator.generateComplianceReport(violations);
  
  const dependencyReport = analyzer.getReport();
  
  const combinedReport = `\n--- DEPENDENCY MAP ---\n${dependencyReport}\n--- COMPLIANCE AUDIT ---\n${complianceReport}`;
  
  const outputPath = path.join(targetDir, 'compliance_output.txt');
  fs.writeFileSync(outputPath, combinedReport);
  console.log(`[OUTPUT] Full report written to: ${outputPath}`);
  
  console.log(combinedReport);
}

run().catch(console.error);
