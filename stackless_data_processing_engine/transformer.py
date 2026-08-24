"""
Data Transformer Module.

Responsible for transforming raw data into a standardized format.
"""

import stackless
import logging
import copy
import time

logger = logging.getLogger('StacklessEngine.Transformer')

class DataTransformer:
    def __init__(self, receive_channel, send_channel):
        self.receive_channel = receive_channel
        self.send_channel = send_channel

    def transform(self, record):
        """
        Perform transformation on a single record.
        """
        transformed = copy.deepcopy(record)
        
        # Example transformations:
        # 1. Normalize timestamp to string
        if 'timestamp' in transformed:
            transformed['timestamp_str'] = time.strftime('%Y-%m-%d %H:%M:%S', 
                                                         time.localtime(transformed['timestamp']))
        
        # 2. Calculate a derived field
        if 'value' in transformed:
            transformed['normalized_value'] = transformed['value'] / 100.0
        
        # 3. Set status
        transformed['status'] = 'transformed'
        
        return transformed

    def run(self):
        """
        Microtask loop to receive data, transform, and send to validator.
        """
        logger.info("Transformer task started.")
        
        while True:
            item = self.receive_channel.receive()
            
            if item is None:
                logger.info("Transformer received EOF.")
                self.send_channel.send(None)
                break
            
            try:
                result = self.transform(item)
                self.send_channel.send(result)
            except Exception as e:
                logger.error("Transformation error: %s", e)
                # Still pass None or error object to validator if needed
                # For this demo, we'll drop errors but log them
        
        logger.info("Transformer task finished.")
