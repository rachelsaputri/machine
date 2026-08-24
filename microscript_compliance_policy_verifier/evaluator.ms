// MicroScript Compliance Policy Verifier - Rule Evaluation Engine

function evaluatePolicy(policy, systemState) {
    var matches = true;
    var details = [];
    for each condition in policy.conditions {
        var actualValue = resolveVariable(condition.target, systemState);
        var expectedValue = condition.value;
        var match = applyOperator(condition.operator, actualValue, expectedValue);
        if (!match) {
            matches = false;
            details.push(`${condition.target} expected ${expectedValue} but found ${actualValue}`);
        }
    }
    return {
        id: policy.id,
        status: matches ? "COMPLIANT" : "NON_COMPLIANT",
        details: details,
        severity: policy.severity
    };
}

function applyOperator(op, actual, expected) {
    switch (op) {
        case "==": return actual == expected;
        case "!=": return actual != expected;
        case ">": return actual > expected;
        case "<": return actual < expected;
        case "contains": return actual.includes(expected);
        default: throw new Error(`Unsupported operator: ${op}`);
    }
}
