class Transformer {
    transform(data) {
        if (!Array.isArray(data)) {
            return data;
        }
        return data.map(item => {
            if (typeof item === 'object' && item !== null) {
                const transformed = {};
                for (const key in item) {
                    transformed[key.toLowerCase()] = item[key];
                }
                return transformed;
            }
            return item;
        });
    }
}

module.exports = { Transformer };
