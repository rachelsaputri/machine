const { Ingestor } = require('./ingester.es');
const { Transformer } = require('./transformer.es');
const { Validator } = require('./validator.es');
const { Reporter } = require('./reporter.es');

class DataProcessingEngine {
    constructor() {
        this.ingester = new Ingestor();
        this.transformer = new Transformer();
        this.validator = new Validator();
        this.reporter = new Reporter();
    }

    async process(data) {
        const ingested = await this.ingester.ingest(data);
        const transformed = this.transformer.transform(ingested);
        const validated = this.validator.validate(transformed);
        const report = this.reporter.generate(validated);
        return report;
    }
}

module.exports = { DataProcessingEngine };
