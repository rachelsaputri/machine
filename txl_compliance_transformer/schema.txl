* TXL Compliance Transformer - Normalization Schema Definitions
* Language: TXL (16.0+)
* Purpose: Define structural patterns for standardizing policy clauses.

RULES
  rule apply_schema:
    [ raw_policies ]
    =>
    [ compliant_policies ]
    :
    rule match_baseline_structure;
    rule fill_missing_attributes;
    rule reject_violations;
  .

RULE
  rule match_baseline_structure:
    [ policy_block ]
    =>
    [ aligned_block ]
    :
    rule align_header;
    rule align_scope_tags;
    rule align_enforcement_level;
  .

RULE
  rule fill_missing_attributes:
    [ partial_block ]
    =>
    [ complete_block ]
    :
    rule insert_default_severity;
    rule insert_default_retention;
    rule insert_default_category;
  .

RULE
  rule reject_violations:
    [ complete_block ]
    =>
    [ rejected_block | passed_block ]
    :
    rule check_forbidden_keywords;
    rule check_mismatched_enforcement;
  .

* End of Schema Definitions
