//
//  EEECyclicDelegateRetainerSpec.m
//  EEEInterventions
//
//  Created by Eric-Paul Lecluse on 16-12-13.
//  Copyright 2013 epologee. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "EEECyclicDelegateRetainer.h"
#import "EEEBeacon.h"
#import "EEEDelegate.h"

SPEC_BEGIN(EEECyclicDelegateRetainerSpec)

        describe(@"EEECyclicDelegateRetainer", ^{
            context(@"with a delegate stack set up", ^{
                __block EEEBeacon *beacon;
                __block EEECyclicDelegateRetainer *sut;

                beforeEach(^{
                    beacon = [[EEEBeacon alloc] init];
                    EEEDelegate *delegate = [[EEEDelegate alloc] init];
                    sut = [[EEECyclicDelegateRetainer alloc] initWithDelegate:delegate];
                    beacon.delegate = (id) sut;
                });

                it(@"forwards message to the delegate", ^{
                    EEEDelegate *delegate = [sut delegate];
                    [[delegate should] receive:@selector(beaconDidFire:)];
                    [beacon fire];
                });

                it(@"retains the delegate until breaking the retain cycle", ^{
                    [[[sut delegate] should] beNonNil];

                    [sut breakRetainCycle];

                    [[[sut delegate] should] beNil];
                });
            });
        });

        SPEC_END
