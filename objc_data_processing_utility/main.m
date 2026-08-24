#import <Foundation/Foundation.h>
#import "DataProcessor.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        DataProcessor *processor = [[DataProcessor alloc] init];
        [processor runPipeline];
    }
    return 0;
}
