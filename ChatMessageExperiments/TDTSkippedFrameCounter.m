//
//  TDTSkippedFrameCounter.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTSkippedFrameCounter.h"

@interface TDTSkippedFrameCounter()

@property (nonatomic, strong) CADisplayLink* link;
@property (nonatomic) CFTimeInterval previousTimestamp;
@property (nonatomic) int missed;
@property (nonatomic) float displayTime;

@end

@implementation TDTSkippedFrameCounter
-(id)initWithDelegate:(id)sender
{
    self = [super init];
    if(self)
    {
        _delegate = sender;
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(targetMethod:)];
        [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

-(void) targetMethod:(CADisplayLink *)displayink
{
    _displayTime = displayink.timestamp - _previousTimestamp;
    if(_displayTime > .017)
    {
        _missed++;
        [_delegate updateSkippedFrames:_missed];
    }
    _previousTimestamp = displayink.timestamp;
    
}
@end
