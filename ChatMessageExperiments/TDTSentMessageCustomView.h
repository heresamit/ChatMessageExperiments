//
//  TDTSentMessageCustomView.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 26/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TDTSentMessageCustomView : UIView

@property (nonatomic) BOOL isSelected;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CALayer *bubbleLayer;
@property (nonatomic) BOOL hasLinks;

- (void) shiftFrameForLandScape;
- (void) shiftFrameForPortrait;
- (id)initWithAttributedText:(NSAttributedString *)attributedText attributedTextBoundingRect:(CGSize)size avatarPic:(id)avatarPic bubblePic:(id)bubblePic bubblePicSize:(CGSize)bubbleImageSize hasLinks:(BOOL)hasLinks  inPortrait:(BOOL)inPortrait;
- (void) updateCustomViewWithAttributedText:(NSAttributedString *)attributedText size:(CGSize)size hasLinks:(BOOL)hasLinks inPortrait:(BOOL)inPortrait;

@end
