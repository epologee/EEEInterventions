#import "EEEMethodInvocationSplitter.h"

@interface EEEMethodInvocationSplitter ()

@property(nonatomic, weak) id intermediary;
@property(nonatomic, weak) id target;

@end

@implementation EEEMethodInvocationSplitter

+ (BOOL)instancesRespondToSelector:(SEL)aSelector
{
    // By design, any method called on this shunt will be forwarded to the delegate
    return YES;
}

- (id)initWithIntermediary:(id)intermediary target:(id)target
{
    self = [super init];

    if (self)
    {
        NSParameterAssert(intermediary && target);
        self.intermediary = intermediary;
        self.target = target;
    }

    return self;
}

#pragma - Method forwaring

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self.intermediary respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:self.intermediary];
    }
    else
    {
        [anInvocation invokeWithTarget:self.target];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self.target respondsToSelector:aSelector])
    {
        return YES;
    }

    return [self.intermediary respondsToSelector:aSelector];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    if ([self.target conformsToProtocol:aProtocol])
    {
        return YES;
    }

    return [self.intermediary conformsToProtocol:aProtocol];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *signature = [self.target methodSignatureForSelector:selector];
    if (!signature)
    {
        signature = [self.intermediary methodSignatureForSelector:selector];
    }
    return signature;
}

@end