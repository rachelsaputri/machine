class Validator {
    validate(data) {
        if (!Array.isArray(data)) {
            return false;
        }
        return data.every(item => item !== null && item !== undefined);
    }
}

module.exports = { Validator };
