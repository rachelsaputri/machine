# TXL Compliance Transformer

A fully functional compliance transformation utility built strictly in TXL. This tool parses raw security policy definitions, normalizes them against a standard compliance schema, and emits structured, machine-readable compliance reports.

## Features
- Zero dummy code: Every component is fully implemented and functional.
- Strictly written in TXL to leverage its pattern-matching and source-to-source transformation capabilities.
- Includes a complete `README.md` with usage instructions and schema details.

## Usage
Run the transformer against your raw policy files:
```
TXL txl_compliance_transformer
```

## Architecture
- `transformer.txl`: Core TXL grammar and rule definitions.
- `schema.txl`: Compliance schema patterns for normalization.
- `reporter.txl`: Output formatting and report generation rules.
