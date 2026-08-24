# Unicon Compliance Auditing Utility

## Overview
This project is a complete, fully functional compliance auditing utility built strictly in **Unicon**. It is designed to ingest configuration files, apply a predefined set of security policies, validate system states against those policies, and generate detailed compliance reports.

## Features
- **Policy Engine:** Parses and evaluates declarative security rules.
- **System Auditor:** Scans target directories/files for compliance deviations.
- **Report Generator:** Outputs structured compliance reports to standard output or files.
- **Logging:** Internal logging for debugging and audit trails.

## Architecture
- `main.icn`: Entry point and orchestration.
- `parser.icn`: File and policy ingestion.
- `engine.icn`: Core compliance evaluation logic.
- `reporter.icn`: Report formatting and output.
- `audit_config.icn`: Default policy definitions and configuration.

## Usage
1. Save the provided `.icn` files in this directory.
2. Run the auditor via the Unicon interpreter:
   ```bash
   icon main.icn --target=/path/to/audit --policy=audit_config.icn
   ```
3. Review the output report for compliance status.

## Requirements
- Unicon language implementation (e.g., Icon/Unicon, OpenIcon)
- Standard POSIX environment (for file system access)

## License
Internal Use Only
