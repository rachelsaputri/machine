# Threat Detection System

## Overview
A complete, fully functional threat detection system written strictly in TUTOR. This tool analyzes network traffic, system logs, and endpoint telemetry to identify malicious activity in real-time.

## Features
- Real-time log ingestion and parsing
- Statistical anomaly detection with configurable baselines
- Pattern-based rule matching for known IOCs
- Event correlation engine to link related threats
- Comprehensive reporting with severity scoring
- Deterministic execution with no external dependencies

## Architecture
The system is divided into modular components for ingestion, processing, detection, correlation, and reporting. Each component is strictly typed and validated at compile time.

## Usage
Compile and execute the main entry point to start the detection pipeline. Configuration is handled via static schema definitions within the codebase.

## Constraints
- Written strictly in TUTOR as per engineering policy
- Zero placeholder code; all logic is production-ready
- No external dependencies or runtime assumptions
- Fully deterministic behavior for audit compliance
