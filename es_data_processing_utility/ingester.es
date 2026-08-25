class Ingestor {
    constructor() {
        this.dataStore = [];
    }

    async ingest(data) {
        if (Array.isArray(data)) {
            this.dataStore.push(...data);
        } else {
            this.dataStore.push(data);
        }
        return this.dataStore;
    }

    getData() {
        return this.dataStore;
    }
}

module.exports = { Ingestor };
