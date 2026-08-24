"""
Data Validator Module.

Responsible for validating data schema and integrity.
"""

import stackless
import logging

logger = logging.getLogger('StacklessEngine.Validator')

REQUIRED_FIELDS = ['id', 'timestamp_str', 'value', 'category', 'normalized_value', 'status']

class DataValidator:
    def __init__(self, receive_channel, send_channel):
        self.receive_channel = receive_channel
        self.send_channel = send_channel
        self.valid_count = 0
        self.invalid_count = 0

    def validate(self, record):
        """
        Validate a record against required schema.
        """
        if not isinstance(record, dict):
            return False, "Record is not a dictionary"
            
        missing_fields = [f for f in REQUIRED_FIELDS if f not in record]
        
        if missing_fields:
            return False, f"Missing fields: {', '.join(missing_fields)}"
            
        if record['status'] != 'transformed':
            return False, "Record not properly transformed"
            
        return True, "Valid"

    def run(self):
        """
        Microtask loop to receive data, validate, and send to reporter.
        """
        logger.info("Validator task started.")
        
        while True:
            item = self.receive_channel.receive()
            
            if item is None:
                logger.info("Validator received EOF.")
                self.send_channel.send(None)
                break
            
            is_valid, message = self.validate(item)
            item['valid'] = is_valid
            item['validation_message'] = message
            
            if is_valid:
                self.valid_count += 1
            else:
                self.invalid_count += 1
            
            self.send_channel.send(item)
        
        logger.info("Validator task finished. Valid: %d, Invalid: %d", self.valid_count, self.invalid_count)
