# Nial Compliance Transformation Tool

A fully functional, standalone compliance transformation engine written strictly in Nial. This tool ingests raw compliance events, normalizes them against a unified schema, transforms them according to target policy frameworks, and exports audit-ready reports.

## Features
- **Data Ingestion:** Parses structured and semi-structured compliance log inputs.
- **Schema Normalization:** Maps disparate event structures to a canonical compliance model.
- **Policy Transformation:** Applies configurable transformation rules to align events with specific compliance frameworks (e.g., NIST, ISO 27001, GDPR).
- **Audit Reporting:** Generates deterministic, exportable compliance manifests.

## Usage
Execute the main Nial script to run the full pipeline:
```
nial main.nial
```

## Architecture
- `ingester.nial`: Reads and tokenizes raw compliance payloads.
- `normalizer.nial`: Enforces type safety and canonical schema mapping.
- `transformer.nial`: Applies policy-specific rule matrices to normalized data.
- `reporter.nial`: Aggregates transformed records into structured compliance reports.
- `main.nial`: Orchestrates the pipeline and handles CLI arguments.

## Compliance
This tool is designed for deterministic, reproducible compliance processing with strict type checking and zero dynamic evaluation of untrusted inputs.
