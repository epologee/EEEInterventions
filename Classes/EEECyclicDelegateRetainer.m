#import "EEECyclicDelegateRetainer.h"
#import "EEEMethodInvocationSplitter.h"

@interface EEECyclicDelegateRetainer ()

@property (nonatomic, strong, readwrite) id delegate;

@end

@implementation EEECyclicDelegateRetainer

+ (BOOL)instancesRespondToSelector:(SEL)aSelector
{
    // By design, any method called on this retainer will be forwarded to the delegate
    return YES;
}

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

- (void)breakRetainCycle
{
    self.delegate = nil;
}

#pragma - Method forwaring

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self.delegate respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:self.delegate];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ( [super respondsToSelector:aSelector] )
    {
        return YES;
    }
    else if ( [self.delegate respondsToSelector:aSelector])
    {
        return YES;
    }

    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    if ([super conformsToProtocol:aProtocol])
    {
        return YES;
    }

    return [self.delegate conformsToProtocol:aProtocol];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        signature = [self.delegate methodSignatureForSelector:aSelector];
    }
    return signature;
}

@end