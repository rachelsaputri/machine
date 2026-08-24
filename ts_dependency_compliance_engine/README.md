# TypeScript Dependency Compliance Engine

## Overview
A production-ready TypeScript-based tool that automatically maps source code dependencies, validates them against configurable compliance policies, and generates detailed audit reports. Designed to integrate into CI/CD pipelines for continuous architecture governance.

## Features
- **Deep Dependency Mapping**: Recursively scans directories and extracts import/export relationships.
- **Policy-Driven Validation**: Load custom JSON policies to enforce coding standards, import limits, and architecture rules.
- **Real-Time Status Tracking**: Categorizes modules as active, deprecated, or missing based on file system resolution.
- **Automated Reporting**: Outputs structured compliance and dependency reports to `compliance_output.txt`.
- **Zero External Dependencies**: Built purely with native Node.js `fs` and `path` modules for maximum reliability.

## Prerequisites
- Node.js >= 14.0
- TypeScript >= 4.5

## Installation & Usage
1. Compile the project:
   ```bash
   npx tsc
   ```
2. Run the analyzer:
   ```bash
   node dist/main.js [target_directory] [policy_file_path]
   ```
   Example:
   ```bash
   node dist/main.js ./src ./policies.json
   ```

## Policy Format
Define compliance rules in `policies.json`:
```json
{
  "id": "POL-XXX",
  "name": "Rule Name",
  "condition": "node.imports.length <= 10",
  "severity": "critical"
}
```
Supported node properties in conditions: `id`, `filePath`, `imports`, `exports`, `status`.

## Architecture
- `DependencyAnalyzer.ts`: Core graph builder and file parser.
- `PolicyValidator.ts`: Rule engine and compliance reporter.
- `main.ts`: CLI orchestrator and output generator.

## License
MIT
