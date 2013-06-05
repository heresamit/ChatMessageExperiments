//
//  TDTLayerBubbleView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTLayerBubbleView.h"
#import <QuartzCore/QuartzCore.h>

@interface TDTLayerBubbleView()

@property (nonatomic) CGSize size;

@end

@implementation TDTLayerBubbleView

- (id)initWithFrame:(CGRect)frame withType:(TDTBubbleType) type withSize:(CGSize) size withBubbleImage:(UIImage *)bubbleImage
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        _size = size;
        _bubbleImage = bubbleImage;
        if(type == sent || type == sentSelected)
            self.frame = CGRectMake( [[UIScreen mainScreen] bounds].size.width - self.size.width - triangleHeight, 0.0f,self.size.width + triangleHeight, self.size.height + YTEXTBUFFER + YCELLBUFFER);
        else
            self.frame = CGRectMake(0.0f,0.0f,self.size.width + triangleHeight,self.size.height + YTEXTBUFFER + YCELLBUFFER);
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
            gradientLayer.frame = CGRectMake(self.frame.size.width - _size.width, YCELLBUFFER/2.0f, self.size.width, self.size.height + YTEXTBUFFER);
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
            
            [self.layer addSublayer:gradientLayer];
            break;
            
        }
        case received:
        {
            
            CALayer* gradientLayer = [[CALayer alloc] init];
            gradientLayer.contents = (__bridge id)(_bubbleImage.CGImage);
            gradientLayer.frame = CGRectMake(0.0f, YCELLBUFFER/2.0f, self.size.width, self.size.height + YTEXTBUFFER);
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
            [self.layer addSublayer:gradientLayer];
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
