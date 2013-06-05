//
//  TDTImageBubbleAvatarAndTextView.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
@interface TDTImageBubbleAvatarAndTextView : UIView
@property (nonatomic) TDTBubbleType type;
@property (nonatomic,weak) UIImage *bubbleImage;
@property (nonatomic,weak) UIImage *avatarImage;
- (id)initWithFrame:(CGRect)frame withType:(TDTBubbleType) type withSize:(CGSize) size withBubbleImage:(UIImage *)bubbleImage withAvatarImage:(UIImage *)avatarImage withText:(NSString *)text;
- (void) shiftFrameForLandScape;
- (void) shiftFrameForPortrait;
@end
