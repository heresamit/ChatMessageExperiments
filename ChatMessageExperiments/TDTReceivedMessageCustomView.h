//
//  TDTReceivedMessageCustomView.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 26/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TDTReceivedMessageCustomView : UIView

@property (nonatomic) BOOL hasLinks;
@property (nonatomic) BOOL isSelected;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) CALayer *bubbleLayer;

- (id)initWithAttributedText:(NSAttributedString *)attributedText attributedTextBoundingRect:(CGSize)size avatarPic:(id)avatarPic bubblePic:(id)bubbPic bubblePicSize:(CGSize)bubbleImageSize hasLinks:(BOOL)hasLinks;
- (void) updateCustomViewWithAttributedText:(NSAttributedString *)attributedText size:(CGSize)size hasLinks:(BOOL)hasLinks;
@end
