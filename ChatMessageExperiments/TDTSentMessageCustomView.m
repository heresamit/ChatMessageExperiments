//
//  TDTSentMessageCustomView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 26/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTSentMessageCustomView.h"
#import "Constants.h"
#import <OHAttributedLabel/OHAttributedLabel.h>

@interface TDTSentMessageCustomView ()

@property (nonatomic, strong) CALayer *avatarLayer;
@property (nonatomic, strong) OHAttributedLabel *textLabel;

@end

@implementation TDTSentMessageCustomView

- (id)initWithAttributedText:(NSAttributedString *)attributedText attributedTextBoundingRect:(CGSize)size avatarPic:(id)avatarPic bubblePic:(id)bubblePic bubblePicSize:(CGSize)bubbleImageSize hasLinks:(BOOL)hasLinks  inPortrait:(BOOL)inPortrait
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _isSelected = NO;
        _hasLinks = hasLinks;
        CGFloat temp = size.width + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        self.frame = CGRectMake( screenSize.width - temp + (!inPortrait ? (screenSize.height - screenSize.width) : 0), 0,temp, MAX(size.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER);
    
        _avatarLayer = [[CALayer alloc] init];
        _avatarLayer.contents = avatarPic;
        _avatarLayer.frame = CGRectMake(self.bounds.size.width - AVATARPICWIDTH - AVATARXBUFFER, YCELLBUFFER/2 , AVATARPICWIDTH, AVATARPICHEIGHT);
        _avatarLayer.contentsScale = [UIScreen mainScreen].scale;
        _avatarLayer.opaque = YES;
        
        _bubbleLayer = [[CALayer alloc] init];
        _bubbleLayer.contents = bubblePic;
        _bubbleLayer.contentsScale = [UIScreen mainScreen].scale;
        _bubbleLayer.opaque = YES;
        _bubbleLayer.contentsCenter = CGRectMake(11.0f/bubbleImageSize.width,17.0f/bubbleImageSize.height,
                                                 (bubbleImageSize.width - 24.0f)/bubbleImageSize.width,
                                                 (bubbleImageSize.height - 28.0f)/bubbleImageSize.height);
        _bubbleLayer.frame = CGRectMake(0,YCELLBUFFER/2,size.width + 3*XTEXTBUFFER/2,size.height +YTEXTBUFFER);
        
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
            _textLayer.frame = CGRectMake(XTEXTBUFFER/2, (YTEXTBUFFER + YCELLBUFFER)/2 - 1.0f, size.width, size.height);
            _textLayer.wrapped = YES;
            _textLayer.actions = newActions;
            [self.layer addSublayer:_textLayer];
        }
        else {
            _textLabel = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(XTEXTBUFFER/2, (YTEXTBUFFER + YCELLBUFFER)/2, size.width, size.height)];
            _textLabel.attributedText = attributedText;
            _textLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:_textLabel];
        }
    }
    return self;
}

- (void) shiftFrameForLandScape
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.transform = CGAffineTransformMakeTranslation((screenSize.height - screenSize.width),0);
}

- (void) shiftFrameForPortrait
{
    self.transform = CGAffineTransformMakeTranslation(0,0);
}

- (void) updateCustomViewWithAttributedText:(NSAttributedString *)attributedText size:(CGSize)size hasLinks:(BOOL)hasLinks inPortrait:(BOOL)inPortrait 
{
    CGFloat temp = size.width + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    self.frame = CGRectMake( screenSize.width - temp + (!inPortrait ? (screenSize.height - screenSize.width ) : 0), 0,temp, MAX(size.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER);
    if(!hasLinks) {
        _textLayer.string = attributedText;
        _textLayer.frame = CGRectMake(XTEXTBUFFER/2, (YTEXTBUFFER + YCELLBUFFER)/2 - 1.0f, size.width, size.height);
    }
    else {
        _textLabel.attributedText = attributedText;
        _textLabel.frame = CGRectMake(XTEXTBUFFER/2, (YTEXTBUFFER + YCELLBUFFER)/2, size.width, size.height);
    }
    
   _bubbleLayer.frame = CGRectMake(0,YCELLBUFFER/2,size.width + 3*XTEXTBUFFER/2,size.height +YTEXTBUFFER);
   _avatarLayer.frame = CGRectMake(self.bounds.size.width - AVATARPICWIDTH - AVATARXBUFFER, YCELLBUFFER/2 , AVATARPICWIDTH, AVATARPICHEIGHT);
    
    [self setNeedsDisplay];
}

@end

/*

 CALayer* gradientLayer = [[CALayer alloc] init];
 gradientLayer.contents = (__bridge id)(_bubbleImage.CGImage);
 gradientLayer.frame = CGRectMake(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - 3.0f*XTEXTBUFFER/2.0f, YCELLBUFFER/2.0f, self.size.width + 3.0f*XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER);
 gradientLayer.contentsScale = [UIScreen mainScreen].scale;
 gradientLayer.contentsCenter = CGRectMake(
 11.0f/_bubbleImage.size.width,
 17.0f/_bubbleImage.size.height,
 //11,17,
 (_bubbleImage.size.width - 24.0f)
 /_bubbleImage.size.width
 , (_bubbleImage.size.height - 28.0f)
 /_bubbleImage.size.height
 );
 gradientLayer.opaque = YES;
 
 [self.layer addSublayer:gradientLayer];
 
 CALayer* imageLayer = [[CALayer alloc] init];
 imageLayer.frame = CGRectMake(self.frame.size.width - AVATARXBUFFER/2.0f - AVATARPICWIDTH, YCELLBUFFER/2.0f, AVATARPICWIDTH,AVATARPICHEIGHT);
 imageLayer.contents = (__bridge id)_avatarImage.CGImage;
 
 imageLayer.opaque = YES;
 
 [self.layer addSublayer:imageLayer];
 
 UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - XTEXTBUFFER, YCELLBUFFER/2.0f + YTEXTBUFFER/2.0f, _size.width,_size.height)];
 textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
 textLabel.text = self.text;
 textLabel.numberOfLines = 0;
 textLabel.backgroundColor = [UIColor clearColor];
 
 [self addSubview:textLabel];
 
*/