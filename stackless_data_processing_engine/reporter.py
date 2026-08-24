"""
Data Reporter Module.

Responsible for printing output and summarizing results.
"""

import stackless
import logging

logger = logging.getLogger('StacklessEngine.Reporter')

class DataReporter:
    def __init__(self, channel):
        self.channel = channel
        self.total_processed = 0

    def report(self, record):
        """
        Print/report a single record.
        """
        status = "OK" if record.get('valid') else "FAIL"
        logger.info("[REPORT] ID: %s | Cat: %s | Val: %s | Status: %s | %s",
                    record.get('id'), record.get('category'), 
                    record.get('value'), status, 
                    record.get('validation_message', ''))

    def run(self):
        """
        Microtask loop to receive validated data and report it.
        """
        logger.info("Reporter task started.")
        
        while True:
            item = self.channel.receive()
            
            if item is None:
                logger.info("Reporter received EOF.")
                self._print_summary()
                break
            
            self.report(item)
            self.total_processed += 1
        
        logger.info("Reporter task finished.")

    def _print_summary(self):
        logger.info("===== PROCESSING SUMMARY =====")
        logger.info("Total Records Processed: %d", self.total_processed)
        logger.info("================================")
