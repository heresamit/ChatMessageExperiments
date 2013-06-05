//
//  TDTImageBubbleView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTImageBubbleView.h"

@interface TDTImageBubbleView()
@property (nonatomic) CGSize size;
@end

@implementation TDTImageBubbleView

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
    
    UIImageView *bubbleImageView;
    
    switch (self.type) {
        case sent:
        {
            bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - self.size.width, YCELLBUFFER/2.0f, self.size.width, self.size.height + YTEXTBUFFER)];
            bubbleImageView.image = [self.bubbleImage stretchableImageWithLeftCapWidth:11 topCapHeight:17];
            break;
        }
        case received:
        {
            bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, YCELLBUFFER/2.0f, self.size.width, self.size.height + YTEXTBUFFER)];
            bubbleImageView.image = [self.bubbleImage stretchableImageWithLeftCapWidth:15 topCapHeight:17];
            break;
        }
        default:
            break;
    }
    [self addSubview:bubbleImageView];
    
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
