# Vala Data Processing Utility

A complete, fully functional data processing utility written in Vala.

This utility provides a modular pipeline for:
- Ingesting data from various sources (files, CSV, JSON).
- Transforming and validating data records.
- Exporting results to CSV or JSON formats.

## Building

Requires the `valac` compiler and the following GTK/GLib libraries:
- `glib-2.0`
- `gobject-2.0`

To compile:
```bash
valac -o data_processor main.val DataProcessor.val DataRecord.val CSVExporter.val JSONExporter.val --pkg glib-2.0 --pkg gobject-2.0
```

## Usage

```bash
./data_processor --input data.csv --format csv --output results.csv --output-format csv
```

## License

MIT
