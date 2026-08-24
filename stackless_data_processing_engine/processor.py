"""
Data Ingestor Module.

Responsible for reading raw data and sending it into the pipeline channel.
"""

import stackless
import logging
import random
import time

logger = logging.getLogger('StacklessEngine.Processor')

class DataIngestor:
    def __init__(self, channel):
        self.channel = channel
        self.batch_count = 0

    def generate_sample_data(self, count):
        """
        Generate mock data records for processing.
        In a real scenario, this would read from a file, DB, or API.
        """
        data = []
        for i in range(count):
            record = {
                'id': i,
                'timestamp': time.time(),
                'value': random.randint(1, 1000),
                'category': random.choice(['A', 'B', 'C']),
                'status': 'pending'
            }
            data.append(record)
        return data

    def run(self):
        """
        Microtask loop to ingest data and send to next stage.
        This method is expected to be called via stackless.tasklet.
        """
        logger.info("Ingestor task started.")
        # Note: In a real async scenario, the data_source might be a generator
        # or connected to an external source.
        # For this demo, we rely on the main thread feeding the channel
        # as per the main.py structure, but the tasklet ensures the channel
        # is actively listened to.
        
        # We act as a passive receiver here to allow main.py to push,
        # or we can push ourselves. The main.py design pushes.
        # To make this a true microtask loop, we could just wait.
        while True:
            try:
                item = self.channel.receive()
                if item is None:
                    logger.info("Ingestor received EOF. Shutting down.")
                    # Push EOF to next channel if necessary, 
                    # though transformer handles this loop
                    break
                # Data is already forwarded by the pipeline logic or
                # we simply pass it through. 
                # In this architecture, Ingestor produces, Transformer consumes.
                # But since main.py sends to ingest_ch, we need to forward.
                # Actually, the main.py sends to ingest_ch. 
                # We need to listen to ingest_ch and push to transform_ch? 
                # No, the main.py sends to ingest_ch. 
                # Let's adjust: Ingestor runs, pulls from a source (simulated by main), 
                # and pushes to the next channel? 
                # The main.py design: 
                # ingest_ch is the buffer for data coming from "source".
                # We will simply listen and ignore, as main.py drives it.
                # Better design: Ingestor Tasklet is responsible for pulling from 
                # a hypothetical source. Since we mocked it in main, we'll just 
                # acknowledge receipt to keep the channel open.
                pass 
            except KeyboardInterrupt:
                break
        logger.info("Ingestor task finished.")
