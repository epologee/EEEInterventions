#import <Foundation/Foundation.h>

@protocol EEEBeaconDelegate;

@interface EEEBeacon : NSObject

@property(nonatomic, weak) id <EEEBeaconDelegate> delegate;

- (void)fire;

@end

@protocol EEEBeaconDelegate <NSObject>

- (void)beaconDidFire:(EEEBeacon *)beacon;

@end