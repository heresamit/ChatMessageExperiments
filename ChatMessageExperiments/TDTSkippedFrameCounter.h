//
//  TDTSkippedFrameCounter.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol skippedFrameCounterProtocol
-(void) updateSkippedFrames:(int)toDisplay;
@end

@interface TDTSkippedFrameCounter : NSObject

@property (nonatomic, weak) id <skippedFrameCounterProtocol> delegate;

- (id)initWithDelegate:(id)sender;
- (void) targetMethod:(CADisplayLink *)displayink;

@end
