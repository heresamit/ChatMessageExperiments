//
//  TDTImageBubbleAndAvatarView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTImageBubbleAndAvatarView.h"
#import <QuartzCore/QuartzCore.h>

@interface TDTImageBubbleAndAvatarView()
@property (nonatomic) CGSize size;
@end

@implementation TDTImageBubbleAndAvatarView

- (id)initWithFrame:(CGRect)frame withType:(TDTBubbleType) type withSize:(CGSize) size withBubbleImage:(UIImage *)bubbleImage withAvatarImage:(UIImage *)avatarImage
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat temp = self.size.width + XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER + triangleHeight;
        _type = type;
        _size = size;
        _bubbleImage = bubbleImage;
        _avatarImage = avatarImage;
        
        if(type == sent || type == sentSelected)
            self.frame = CGRectMake( [[UIScreen mainScreen] bounds].size.width - temp, 0.0f,temp, MAX(self.size.height + YTEXTBUFFER , AVATARPICHEIGHT) + YCELLBUFFER);
        
        self.backgroundColor = [UIColor clearColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    
    UIImageView *bubbleImageView, *avatarImageView;
    
    switch (self.type) {
        case sent:
        {
            bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - 3.0f*XTEXTBUFFER/2.0f, YCELLBUFFER/2.0f, self.size.width + 3.0f*XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER)];
            bubbleImageView.image = [self.bubbleImage stretchableImageWithLeftCapWidth:11 topCapHeight:17];
            avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - AVATARXBUFFER/2.0f - AVATARPICWIDTH, YCELLBUFFER/2.0f, AVATARPICWIDTH,AVATARPICHEIGHT)];
            avatarImageView.image = self.avatarImage;
            break;
        }
        case received:
        {
            bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f, self.size.width + 3.0f * XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER)];
            bubbleImageView.image = [self.bubbleImage stretchableImageWithLeftCapWidth:15 topCapHeight:17];
           
            avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AVATARXBUFFER/2 , YCELLBUFFER/2, AVATARPICWIDTH,AVATARPICHEIGHT)];
            avatarImageView.image = self.avatarImage;
            
            break;
        }
        default:
            break;
    }
    bubbleImageView.opaque= YES;
    avatarImageView.opaque = YES;
    [self addSubview:bubbleImageView];
    [self addSubview:avatarImageView];
    
    
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
