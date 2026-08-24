import * as fs from 'fs';
import * as path from 'path';

export interface DependencyNode {
  id: string;
  filePath: string;
  imports: string[];
  exports: string[];
  status: 'active' | 'deprecated' | 'missing';
}

export interface DependencyGraph {
  nodes: Map<string, DependencyNode>;
  edges: Map<string, Set<string>>;
}

export class DependencyAnalyzer {
  private graph: DependencyGraph = {
    nodes: new Map(),
    edges: new Map(),
  };

  public async analyzeDirectory(dirPath: string, extensions: string[] = ['.ts', '.tsx']): Promise<DependencyGraph> {
    const files = this.getAllFiles(dirPath, extensions);
    for (const file of files) {
      this.processFile(file, extensions);
    }
    return this.graph;
  }

  private getAllFiles(dirPath: string, extensions: string[]): string[] {
    const results: string[] = [];
    const list = fs.readdirSync(dirPath);
    for (const file of list) {
      const filePath = path.join(dirPath, file);
      const stat = fs.statSync(filePath);
      if (stat.isDirectory()) {
        results.push(...this.getAllFiles(filePath, extensions));
      } else if (extensions.some(ext => filePath.endsWith(ext))) {
        results.push(filePath);
      }
    }
    return results;
  }

  private processFile(filePath: string, extensions: string[]): void {
    const content = fs.readFileSync(filePath, 'utf-8');
    const imports = this.extractImports(content);
    const exports = this.extractExports(content);
    const nodeId = path.relative(process.cwd(), filePath);
    
    this.graph.nodes.set(nodeId, {
      id: nodeId,
      filePath: filePath,
      imports: imports,
      exports: exports,
      status: this.validateStatus(imports, filePath, extensions),
    });

    for (const imp of imports) {
      if (!this.graph.edges.has(nodeId)) {
        this.graph.edges.set(nodeId, new Set());
      }
      this.graph.edges.get(nodeId)!.add(imp);
    }
  }

  private extractImports(content: string): string[] {
    const importRegex = /import\s+(?:.*?\s+from\s+)?['"]([^'"]+)['"]/g;
    const imports: string[] = [];
    let match;
    while ((match = importRegex.exec(content)) !== null) {
      const raw = match[1];
      if (raw.startsWith('.')) {
        imports.push(raw);
      }
    }
    return imports;
  }

  private extractExports(content: string): string[] {
    const exportRegex = /export\s+(?:default\s+)?(?:class|interface|type|const|function|var|let)\s+([a-zA-Z0-9_]+)/g;
    const exports: string[] = [];
    let match;
    while ((match = exportRegex.exec(content)) !== null) {
      exports.push(match[1]);
    }
    return exports;
  }

  private validateStatus(imports: string[], filePath: string, extensions: string[]): 'active' | 'deprecated' | 'missing' {
    if (imports.length === 0) return 'active';
    for (const imp of imports) {
      const resolved = this.resolveModulePath(imp, filePath, extensions);
      if (!resolved || !fs.existsSync(resolved)) {
        return 'missing';
      }
    }
    return 'active';
  }

  private resolveModulePath(importPath: string, currentFilePath: string, extensions: string[]): string | null {
    const currentDir = path.dirname(currentFilePath);
    let resolvedPath = path.join(currentDir, importPath);
    
    for (const ext of extensions) {
      if (fs.existsSync(resolvedPath + ext)) {
        return resolvedPath + ext;
      }
      if (fs.existsSync(resolvedPath) && fs.statSync(resolvedPath).isDirectory()) {
        const indexPath = path.join(resolvedPath, 'index' + ext);
        if (fs.existsSync(indexPath)) return indexPath;
      }
    }
    return null;
  }

  public getReport(): string {
    let report = '=== Dependency Compliance Report ===\n\n';
    report += `Total Nodes: ${this.graph.nodes.size}\n`;
    report += `Total Edges: ${Array.from(this.graph.edges.values()).reduce((acc, set) => acc + set.size, 0)}\n\n`;

    const missing: string[] = [];
    const active: string[] = [];
    const deprecated: string[] = [];

    this.graph.nodes.forEach(node => {
      if (node.status === 'missing') missing.push(node.id);
      else if (node.status === 'deprecated') deprecated.push(node.id);
      else active.push(node.id);
    });

    report += `Active Modules: ${active.length}\n`;
    report += `Missing Dependencies: ${missing.length}\n`;
    report += `Deprecated Modules: ${deprecated.length}\n\n`;

    if (missing.length > 0) {
      report += 'Missing Dependencies:\n';
      missing.forEach(m => report += `  - ${m}\n`);
      report += '\n';
    }

    return report;
  }
}
