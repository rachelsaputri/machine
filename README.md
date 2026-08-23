# BREW Data Processing Utility

A fully functional, production-ready data processing utility written in BREW.

This tool provides a pipeline for:
- Ingesting data from input sources
- Validating data integrity and structure
- Transforming data fields
- Generating reports

## Usage

### Prerequisites
- BREW environment installed

### Running the Utility

1. Save the BREW script files in this directory.
2. Run the main processing script:

   ```bash
   brew run main.brew
   ```

### Configuration

The utility uses a configuration file (`config.brew` or inline configuration) to define:
- Input file paths
- Validation rules
- Transformation functions
- Output destinations

### File Structure

- `main.brew`: Entry point, initializes and runs the pipeline.
- `parser.brew`: Handles data ingestion and parsing.
- `validator.brew`: Validates parsed data against defined rules.
- `transformer.brew`: Applies transformations to valid data.
- `reporter.brew`: Generates output reports.

## Example

Given an input CSV file `data.csv`:

```csv
id,name,age
1,Alice,30
2,Bob,25
3,Charlie,35
```

Running the utility will:
1. Parse the CSV data.
2. Validate that all records have valid `id`, `name`, and `age`.
3. Transform `name` to uppercase and `age` to a string.
4. Output a report to `report.txt`.

## Output

The generated report (`report.txt`) will contain:

```
=== Data Processing Report ===

Processed Records:
ID: 1, NAME: ALICE, AGE: 30
ID: 2, NAME: BOB, AGE: 25
ID: 3, NAME: CHARLIE, AGE: 35

Validation Status: PASSED
Total Records Processed: 3
Total Records Valid: 3
Total Records Invalid: 0
```

## License

MIT

- Created/Updated module: `./bpel_data_processing_utility` (See `./bpel_data_processing_utility/README.md` for details)

- Created/Updated module: `cpp_advanced_data_processing_utility` (See `cpp_advanced_data_processing_utility/README.md` for details)

- Created/Updated module: `lil_data_processing_utility` (See `lil_data_processing_utility/README.md` for details)

- Created/Updated module: `./ch_data_processing_utility` (See `./ch_data_processing_utility/README.md` for details)

- Created/Updated module: `basic_data_processing_utility` (See `basic_data_processing_utility/README.md` for details)

- Created/Updated module: `./opencl_data_processing_utility` (See `./opencl_data_processing_utility/README.md` for details)

- Created/Updated module: `./lithe_data_processing_utility` (See `./lithe_data_processing_utility/README.md` for details)

- Created/Updated module: `kuka_data_processing_utility` (See `kuka_data_processing_utility/README.md` for details)

- Created/Updated module: `ngl_data_processing_utility` (See `ngl_data_processing_utility/README.md` for details)

- Created/Updated module: `./cl_data_processing_utility` (See `./cl_data_processing_utility/README.md` for details)

- Created/Updated module: `dc_compliance_data_processor` (See `dc_compliance_data_processor/README.md` for details)

- Created/Updated module: `jcl_data_processing_utility` (See `jcl_data_processing_utility/README.md` for details)

- Created/Updated module: `./elixir_data_processing_utility` (See `./elixir_data_processing_utility/README.md` for details)

- Created/Updated module: `epigram_data_processing_utility` (See `epigram_data_processing_utility/README.md` for details)

- Created/Updated module: `dasl_compliance_data_processor` (See `dasl_compliance_data_processor/README.md` for details)

- Created/Updated module: `bash_data_processing_utility` (See `bash_data_processing_utility/README.md` for details)

- Created/Updated module: `cilk_parallel_data_processing_utility` (See `cilk_parallel_data_processing_utility/README.md` for details)

- Created/Updated module: `./falcon_data_processing_utility` (See `./falcon_data_processing_utility/README.md` for details)

- Created/Updated module: `plus_data_processing_utility` (See `plus_data_processing_utility/README.md` for details)

- Created/Updated module: `./moby_data_processing_utility` (See `./moby_data_processing_utility/README.md` for details)

- Created/Updated module: `oxygene_data_processing_utility` (See `oxygene_data_processing_utility/README.md` for details)

- Created/Updated module: `cel_data_processing_utility` (See `cel_data_processing_utility/README.md` for details)

- Created/Updated module: `gcode_data_processing_utility` (See `gcode_data_processing_utility/README.md` for details)

- Created/Updated module: `gpss_data_processing_utility` (See `gpss_data_processing_utility/README.md` for details)

- Created/Updated module: `./gpss_data_processing_utility` (See `./gpss_data_processing_utility/README.md` for details)

- Created/Updated module: `tex_data_processing_utility` (See `tex_data_processing_utility/README.md` for details)

- Created/Updated module: `hal_data_processing_utility` (See `hal_data_processing_utility/README.md` for details)

- Created/Updated module: `vb_data_processing_utility` (See `vb_data_processing_utility/README.md` for details)

- Created/Updated module: `sawzall_data_processing_utility` (See `sawzall_data_processing_utility/README.md` for details)

- Created/Updated module: `./io_data_processing_utility` (See `./io_data_processing_utility/README.md` for details)

- Created/Updated module: `iptscrae_data_processing_utility` (See `iptscrae_data_processing_utility/README.md` for details)

- Created/Updated module: `ispf_data_processing_utility` (See `ispf_data_processing_utility/README.md` for details)

- Created/Updated module: `latex_data_processing_utility` (See `latex_data_processing_utility/README.md` for details)

- Created/Updated module: `provide_x_data_processing_utility` (See `provide_x_data_processing_utility/README.md` for details)

- Created/Updated module: `msl_data_processing_utility` (See `msl_data_processing_utility/README.md` for details)

- Created/Updated module: `chapel_security_anomaly_detector` (See `chapel_security_anomaly_detector/README.md` for details)

- Created/Updated module: `axiom_crypto_protocol_verifier` (See `axiom_crypto_protocol_verifier/README.md` for details)

- Created/Updated module: `ici_compliance_auditor` (See `ici_compliance_auditor/README.md` for details)

- Created/Updated module: `splus_data_processing_utility` (See `splus_data_processing_utility/README.md` for details)

- Created/Updated module: `./gpss_data_processing_utility` (See `./gpss_data_processing_utility/README.md` for details)

- Created/Updated module: `./nasm_data_processing_utility` (See `./nasm_data_processing_utility/README.md` for details)

- Created/Updated module: `alf_data_processing_utility_new` (See `alf_data_processing_utility_new/README.md` for details)

- Created/Updated module: `hugo_data_processing_utility` (See `hugo_data_processing_utility/README.md` for details)

- Created/Updated module: `machine_code_data_processing_utility` (See `machine_code_data_processing_utility/README.md` for details)

- Created/Updated module: `mary_data_processing_utility` (See `mary_data_processing_utility/README.md` for details)

- Created/Updated module: `maxima_data_processing_utility` (See `maxima_data_processing_utility/README.md` for details)

- Created/Updated module: `lse_data_processing_utility` (See `lse_data_processing_utility/README.md` for details)

- Created/Updated module: `./moo_data_processing_utility` (See `./moo_data_processing_utility/README.md` for details)

- Created/Updated module: `rex_data_processing_utility` (See `rex_data_processing_utility/README.md` for details)

- Created/Updated module: `harbour_data_processing_utility` (See `harbour_data_processing_utility/README.md` for details)

- Created/Updated module: `setl_data_processing_utility` (See `setl_data_processing_utility/README.md` for details)

- Created/Updated module: `./nemerle_data_processing_utility` (See `./nemerle_data_processing_utility/README.md` for details)

- Created/Updated module: `netrexx_data_processing_utility` (See `netrexx_data_processing_utility/README.md` for details)

- Created/Updated module: `newp_data_processing_utility` (See `newp_data_processing_utility/README.md` for details)

- Created/Updated module: `newspeak_data_processing_utility` (See `newspeak_data_processing_utility/README.md` for details)

- Created/Updated module: `newton_data_processing_utility` (See `newton_data_processing_utility/README.md` for details)

- Created/Updated module: `ngl_data_processing_utility` (See `ngl_data_processing_utility/README.md` for details)

- Created/Updated module: `txl_compliance_transformer` (See `txl_compliance_transformer/README.md` for details)

- Created/Updated module: `nial_compliance_transformation_tool` (See `nial_compliance_transformation_tool/README.md` for details)

- Created/Updated module: `xml_data_processing_utility` (See `xml_data_processing_utility/README.md` for details)

- Created/Updated module: `haxe_data_processing_utility` (See `haxe_data_processing_utility/README.md` for details)

- Created/Updated module: `swift_parallel_data_processor` (See `swift_parallel_data_processor/README.md` for details)

- Created/Updated module: `xl_data_processing_utility` (See `xl_data_processing_utility/README.md` for details)

- Created/Updated module: `oz_data_processing_utility` (See `oz_data_processing_utility/README.md` for details)

- Created/Updated module: `godiva_data_processing_utility` (See `godiva_data_processing_utility/README.md` for details)

- Created/Updated module: `pl11_data_processing_utility` (See `pl11_data_processing_utility/README.md` for details)

- Created/Updated module: `plankalkul_data_processing_utility` (See `plankalkul_data_processing_utility/README.md` for details)

- Created/Updated module: `plex_data_processing_utility` (See `plex_data_processing_utility/README.md` for details)

- Created/Updated module: `lustre_data_processing_utility` (See `lustre_data_processing_utility/README.md` for details)

- Created/Updated module: `pure_data_processing_engine` (See `pure_data_processing_engine/README.md` for details)

- Created/Updated module: `r_data_processing_utility` (See `r_data_processing_utility/README.md` for details)

- Created/Updated module: `./rapira_data_processing_utility` (See `./rapira_data_processing_utility/README.md` for details)

- Created/Updated module: `genie_data_processing_utility` (See `genie_data_processing_utility/README.md` for details)

- Created/Updated module: `revolution_data_processing_utility` (See `revolution_data_processing_utility/README.md` for details)

- Created/Updated module: `./s_data_processing_utility` (See `./s_data_processing_utility/README.md` for details)

- Created/Updated module: `rsl_data_processing_utility` (See `rsl_data_processing_utility/README.md` for details)
