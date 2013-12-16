//
//  EEEMethodInvocationSplitterSpec.m
//  EEEInterventions
//
//  Created by Eric-Paul Lecluse on 16-12-13.
//  Copyright 2013 epologee. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "EEEMethodInvocationSplitter.h"
#import "EEESplittable.h"

SPEC_BEGIN(EEEMethodInvocationSplitterSpec)

describe(@"EEEMethodInvocationSplitter", ^{
    it(@"raises an exception for unimplemented methods", ^{
        id intermediary = [EEESplittable mockWithName:@"intermediary"];
        id target = [[EEESplittable alloc] init];
        id sut = [[EEEMethodInvocationSplitter alloc] initWithIntermediary:intermediary target:target];

        [[theBlock(^{
            [sut performUnimplementedFeat];
        }) should] raise];
    });

    context(@"with mock intermediary and target objects", ^{
        __block id intermediary;
        __block id target;
        __block id sut;
        
        beforeEach(^{
            intermediary = [EEESplittable mockWithName:@"intermediary"];
            target = [EEESplittable mockWithName:@"target"];
            sut = [[EEEMethodInvocationSplitter alloc] initWithIntermediary:intermediary target:target];
        });
        
        it(@"executes the intermediary's method", ^{
            [[intermediary should] receive:@selector(performRequiredFeat)];
            [sut performRequiredFeat];
        });

        it(@"executes the target's method", ^{
            [[target should] receive:@selector(performOptionalFeat)];
            [sut performOptionalFeat];
        });
    });
});

SPEC_END
