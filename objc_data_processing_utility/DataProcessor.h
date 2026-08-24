#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ProcessingCompletionHandler)(BOOL success, NSError * _Nullable error);

class DataProcessor : NSObject
@end

NS_ASSUME_NONNULL_END
