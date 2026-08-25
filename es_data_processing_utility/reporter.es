class Reporter {
    generate(data) {
        return {
            status: 'completed',
            recordCount: Array.isArray(data) ? data.length : 0,
            data: data
        };
    }
}

module.exports = { Reporter };
