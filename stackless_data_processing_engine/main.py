#!/usr/bin/env stackless
"""
Main entry point for the Stackless Python Data Processing Engine.

Orchestrates the microtask pipeline by creating channels and launching
processor, transformer, validator, and reporter tasks.
"""

import stackless
import logging

from processor import DataIngestor
from transformer import DataTransformer
from validator import DataValidator
from reporter import DataReporter

logging.basicConfig(level=logging.INFO, format='%(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger('StacklessEngine')

def create_pipeline():
    """Create the communication channels for the pipeline."""
    # Channels connect stages:
    # Ingestor -> Transformer -> Validator -> Reporter
    ingest_channel = stackless.channel()
    transform_channel = stackless.channel()
    validate_channel = stackless.channel()
    report_channel = stackless.channel()
    
    return ingest_channel, transform_channel, validate_channel, report_channel

def run_pipeline(batch_size=100):
    """Initialize and run the data processing pipeline."""
    logger.info("Initializing Stackless Data Processing Engine...")
    
    ingest_ch, transform_ch, validate_ch, report_ch = create_pipeline()
    
    # Initialize components
    ingestor = DataIngestor(ingest_ch)
    transformer = DataTransformer(transform_ch, validate_ch)
    validator = DataValidator(validate_ch, report_ch)
    reporter = DataReporter(report_ch)
    
    # Register tasks
    task_ingest = stackless.tasklet(ingestor.run)()
    task_transform = stackless.tasklet(transformer.run)()
    task_validate = stackless.tasklet(validator.run)()
    task_report = stackless.tasklet(reporter.run)()
    
    logger.info("Pipeline started. Processing batches of size %d...", batch_size)
    
    # Simulate incoming data source
    data_source = ingestor.generate_sample_data(batch_size)
    
    # Feed data into the pipeline
    for item in data_source:
        ingest_ch.send(item)
    
    # Signal end of stream (using None as EOF)
    ingest_ch.send(None)
    
    # Wait for completion
    task_report.wait()
    
    logger.info("Pipeline finished successfully.")

if __name__ == "__main__":
    run_pipeline()
