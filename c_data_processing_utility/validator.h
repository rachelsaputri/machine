#ifndef VALIDATOR_H
#define VALIDATOR_H

#include "processor.h"

int validate_record(DataRecord *record);
int validate_batch(DataBatch *batch);

#endif
