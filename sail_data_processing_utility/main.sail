module main;

import data_ingester;
import data_validator;
import data_transformer;
import data_reporter;

function main() {
    var data = data_ingester.IngestData();
    if (data.is_empty()) {
        report_error("No data to process.");
        return;
    }

    var validated_data = data_validator.Validate(data);
    if (!validated_data.is_valid()) {
        report_error("Validation failed.");
        return;
    }

    var transformed_data = data_transformer.Transform(validated_data);
    data_reporter.Report(transformed_data);
}
