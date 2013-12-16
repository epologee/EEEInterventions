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
#import "EEECyclicSubclass.h"

SPEC_BEGIN(EEECyclicDelegateRetainerSpec)

        describe(@"EEECyclicDelegateRetainer", ^{
            context(@"composition", ^{
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

            context(@"inheritance", ^{
                it(@"allows subclassing", ^{
                    EEECyclicSubclass *subSut = [[EEECyclicSubclass alloc] initWithDelegate:[[EEEDelegate alloc] init]];
                    [[subSut.delegate should] beNonNil];

                    [subSut breakRetainCycle];

                    [[subSut.delegate should] beNil];
                });

                it(@"performs selectors on the subclass if the delegate does not respond", ^{
                    EEECyclicSubclass *subSut = [[EEECyclicSubclass alloc] initWithDelegate:[[EEEDelegate alloc] init]];

                    [[subSut should] receive:@selector(fallbackMethod)];

                    [subSut fallbackMethod];
                });
            });
        });

        SPEC_END
