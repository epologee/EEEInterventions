#import <Foundation/Foundation.h>

@interface EEEMethodInvocationSplitter : NSObject

/**
* The splitter will keep a *weak* reference to both intermediary and target
*/
- (id)initWithIntermediary:(id)intermediary target:(id)target;

@end