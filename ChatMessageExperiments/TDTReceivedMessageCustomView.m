//
//  TDTReceivedMessageCustomView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 26/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTReceivedMessageCustomView.h"
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "Constants.h"

@interface TDTReceivedMessageCustomView ()

@property (nonatomic, strong) CALayer *avatarLayer;
@property (nonatomic, strong) OHAttributedLabel *textLabel;

@end

@implementation TDTReceivedMessageCustomView

- (id)initWithAttributedText:(NSAttributedString *)attributedText attributedTextBoundingRect:(CGSize)size avatarPic:(id)avatarPic bubblePic:(id)bubblePic bubblePicSize:(CGSize)bubbleImageSize hasLinks:(BOOL)hasLinks
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        _isSelected = NO;
        _hasLinks = hasLinks;
        CGFloat temp = size.width + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
        self.frame = CGRectMake(0, 0, temp, MAX(size.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER);
        
        _avatarLayer = [[CALayer alloc] init];
        _avatarLayer.contents = avatarPic;
        _avatarLayer.frame = CGRectMake(AVATARXBUFFER/2, YCELLBUFFER/2, AVATARPICWIDTH, AVATARPICHEIGHT);
        _avatarLayer.contentsScale = [UIScreen mainScreen].scale;
        _avatarLayer.opaque = YES;
        
        _bubbleLayer = [[CALayer alloc] init];
        _bubbleLayer.contents = bubblePic;
        _bubbleLayer.contentsScale = [UIScreen mainScreen].scale;
        _bubbleLayer.opaque = YES;
        _bubbleLayer.contentsCenter = CGRectMake(15.0f/bubbleImageSize.width,
                                                 17.0f/bubbleImageSize.height,
                                                 (bubbleImageSize.width - 30.0f)/bubbleImageSize.width,
                                                 (bubbleImageSize.height - 28.0f)/bubbleImageSize.height);
        _bubbleLayer.frame = CGRectMake(AVATARXBUFFER + AVATARPICWIDTH ,YCELLBUFFER/2, size.width + 3*XTEXTBUFFER/2, size.height +YTEXTBUFFER);
        
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"onOrderIn",
                                           [NSNull null], @"onOrderOut",
                                           [NSNull null], @"sublayers",
                                           [NSNull null], @"contents",
                                           [NSNull null], @"bounds",
                                           [NSNull null], @"position",
                                           [NSNull null], @"hidden",
                                           nil];
        _bubbleLayer.actions = newActions;
        _avatarLayer.actions = newActions;
        
        [self.layer addSublayer:_avatarLayer];
        [self.layer addSublayer:_bubbleLayer];
        
        if(!hasLinks) {
            _textLayer = [[CATextLayer alloc] init];
            _textLayer.contentsScale = [UIScreen mainScreen].scale;
            _textLayer.string = attributedText;
            _textLayer.frame = CGRectMake(XTEXTBUFFER/2 + triangleHeight + AVATARPICWIDTH + AVATARXBUFFER, (YTEXTBUFFER + YCELLBUFFER)/2 - 1.0f, size.width, size.height);
            _textLayer.wrapped = YES;
            _textLayer.actions = newActions;
            [self.layer addSublayer:_textLayer];
        }
        else {
            _textLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(XTEXTBUFFER/2 + triangleHeight + AVATARPICWIDTH + AVATARXBUFFER, (YTEXTBUFFER + YCELLBUFFER)/2, size.width, size.height)];
            _textLabel.attributedText = attributedText;
            _textLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:_textLabel];
        }
    }
    return self;
}


- (void) updateCustomViewWithAttributedText:(NSAttributedString *)attributedText size:(CGSize)size hasLinks:(BOOL)hasLinks
{
    CGFloat temp = size.width + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    self.frame = CGRectMake(0, 0, temp, MAX(size.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER);
    
    
    if(!hasLinks) {
        _textLayer.string = attributedText;
        _textLayer.frame = CGRectMake(XTEXTBUFFER/2 + triangleHeight + AVATARPICWIDTH + AVATARXBUFFER, (YTEXTBUFFER + YCELLBUFFER)/2 - 1.0f, size.width, size.height);
    }
    else {
        _textLabel.frame = CGRectMake(XTEXTBUFFER/2 + triangleHeight + AVATARPICWIDTH + AVATARXBUFFER, (YTEXTBUFFER + YCELLBUFFER)/2, size.width, size.height);
        _textLabel.attributedText = attributedText;
    }
    
    _bubbleLayer.frame = CGRectMake(AVATARXBUFFER + AVATARPICWIDTH ,YCELLBUFFER/2, size.width + 3*XTEXTBUFFER/2, size.height +YTEXTBUFFER);
    
    [self setNeedsDisplay];
}

@end
