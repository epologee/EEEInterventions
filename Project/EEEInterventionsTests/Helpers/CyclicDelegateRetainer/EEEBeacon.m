#import "EEEBeacon.h"

@implementation EEEBeacon

- (void)fire
{
    [self.delegate beaconDidFire:self];
}

@end