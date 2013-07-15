//
//  TDTLayerBubbleAvatarAndTextView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTLayerBubbleAvatarAndTextView.h"
#import <QuartzCore/QuartzCore.h>

@interface TDTLayerBubbleAvatarAndTextView()
@property (nonatomic) CGSize size;
@property (nonatomic,weak) NSString* text;
@end

@implementation TDTLayerBubbleAvatarAndTextView
- (id)initWithFrame:(CGRect)frame withType:(TDTBubbleType) type withSize:(CGSize) size withBubbleImage:(UIImage *)bubbleImage withAvatarImage:(UIImage *)avatarImage withText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat temp = self.size.width + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
        _type = type;
        _size = size;
        _bubbleImage = bubbleImage;
        _avatarImage = avatarImage;
        _text = text;
        if(type == sent || type == sentSelected)
            self.frame = CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(self.size.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER);

        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    
    switch (self.type) {
        case sent:
        {
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
            
            break;
            
        }
        case received:
        {
            CALayer* gradientLayer = [[CALayer alloc] init];
            gradientLayer.contents = (__bridge id)(_bubbleImage.CGImage);
            gradientLayer.frame = CGRectMake(AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f, self.size.width + 3.0f * XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER);
            gradientLayer.contentsScale = [UIScreen mainScreen].scale;
            gradientLayer.contentsCenter = CGRectMake(
                                                      15.0f/_bubbleImage.size.width,
                                                      17.0f/_bubbleImage.size.height,
                                                      //11,17,
                                                      (_bubbleImage.size.width - 30.0f)
                                                      /_bubbleImage.size.width
                                                      , (_bubbleImage.size.height - 28.0f)
                                                      /_bubbleImage.size.height
                                                      );
            gradientLayer.opaque = YES;
            
            [self.layer addSublayer:gradientLayer];
            
            CALayer* imageLayer = [[CALayer alloc] init];
            imageLayer.frame = CGRectMake(AVATARXBUFFER/2 , YCELLBUFFER/2, AVATARPICWIDTH,AVATARPICHEIGHT);
            imageLayer.contents = (__bridge id)_avatarImage.CGImage;
            imageLayer.opaque = YES;
            
            [self.layer addSublayer:imageLayer];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f + YTEXTBUFFER/2.0f, _size.width,_size.height)];
            textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
            textLabel.text = self.text;
            textLabel.numberOfLines = 0.0f;
            textLabel.backgroundColor = [UIColor clearColor];
            [self addSubview:textLabel];
            
            break;
        }
        default:
            break;
    }
    
}

- (void) shiftFrameForLandScape
{
    self.transform = CGAffineTransformMakeTranslation(160,0);
}

- (void) shiftFrameForPortrait
{
    self.transform = CGAffineTransformMakeTranslation(0,0);
}

@end
