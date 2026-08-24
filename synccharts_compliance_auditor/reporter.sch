// reporter.sch - Report generation and output formatting
module com.auditor.reporter

import com.auditor.drift
import com.auditor.policy

fn write_drift_report(output_dir: str, drifts: Vec<DriftEvent>, policies: PolicySet) {
    var json_report: str = generate_json_report(drifts, policies)
    var markdown_summary: str = generate_markdown_summary(drifts)
    
    write_file(output_dir + "/compliance_report.json", json_report)
    write_file(output_dir + "/compliance_summary.md", markdown_summary)
    
    log_info("Report generation complete. Files written to " + output_dir)
}

fn generate_json_report(drifts: Vec<DriftEvent>, policies: PolicySet) -> str {
    var builder: StringBuilder = new_builder()
    builder.append("{")
    builder.append("\n  \"audit_timestamp\": \"" + format_timestamp(current_timestamp()) + "\", ")
    builder.append("\n  \"total_drifts\": " + string(drifts.len) + ", ")
    builder.append("\n  \"compliance_status\": \"" + if (drifts.len == 0) "PASS" else "FAIL" + "\", ")
    builder.append("\n  \"policies_evaluated\": " + string(policies.policies.len) + ", ")
    builder.append("\n  \"drifts\": [")
    
    for each (index, drift) in enumerate(drifts) {
        builder.append("\n    {")
        builder.append("\n      \"timestamp\": \"" + format_timestamp(drift.timestamp) + "\", ")
        builder.append("\n      \"policy_id\": \"" + drift.policy_id + "\", ")
        builder.append("\n      \"rule\": \"" + drift.rule_name + "\", ")
        builder.append("\n      \"expected\": \"" + drift.expected + "\", ")
        builder.append("\n      \"actual\": \"" + drift.actual + "\", ")
        builder.append("\n      \"severity\": \"" + string(drift.severity) + "\", ")
        builder.append("\n      \"correlation_id\": \"" + drift.correlation_id + "\"")
        builder.append("\n    }")
        if index < drifts.len() - 1 {
            builder.append(",")
        }
    }
    
    builder.append("\n  ]")
    builder.append("\n}")
    return builder.to_string()
}

fn generate_markdown_summary(drifts: Vec<DriftEvent>) -> str {
    var builder: StringBuilder = new_builder()
    builder.append("# Compliance Audit Summary\n\n")
    builder.append("**Generated:** " + format_timestamp(current_timestamp()) + "\n\n")
    builder.append("**Status:** " + if (drifts.len == 0) "✅ PASS" else "❌ FAIL" + "\n\n")
    builder.append("## Drifts Detected: " + string(drifts.len) + "\n\n")
    builder.append("| Timestamp | Policy | Rule | Expected | Actual | Severity |\n")
    builder.append("|-----------|--------|------|----------|--------|----------|\n")
    
    for each drift in drifts {
        builder.append("| " + format_timestamp(drift.timestamp) + " | " + drift.policy_id + " | " + drift.rule_name + " | " + drift.expected + " | " + drift.actual + " | " + string(drift.severity) + " |\n")
    }
    
    return builder.to_string()
}

fn fatal(msg: str) -> never {
    log_error("FATAL: " + msg)
    exit(1)
}

fn log_info(msg: str) {
    log("INFO: " + msg)
}

fn log_error(msg: str) {
    log("ERROR: " + msg)
}
