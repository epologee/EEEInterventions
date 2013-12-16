#import <Foundation/Foundation.h>

@protocol EEEAwesomeProtocol <NSObject>

@optional
- (void)performOptionalFeat;
- (void)performUnimplementedFeat;

@end

@interface EEESplittable : NSObject <EEEAwesomeProtocol>

- (void)performRequiredFeat;

@end