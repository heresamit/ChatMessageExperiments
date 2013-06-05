//
//  TDTImageBubbleAvatarAndTextView.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTImageBubbleAvatarAndTextView.h"
#import <QuartzCore/QuartzCore.h>

@interface TDTImageBubbleAvatarAndTextView()
@property (nonatomic) CGSize size;
@property (nonatomic,weak) NSString* text;
@end

@implementation TDTImageBubbleAvatarAndTextView

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
    
    UIImageView *bubbleImageView, *avatarImageView;
    UILabel *textLabel;
    switch (self.type) {
        case sent:
        {
            bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - 3.0f*XTEXTBUFFER/2.0f, YCELLBUFFER/2.0f, self.size.width + 3.0f*XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER)];
            bubbleImageView.image = [self.bubbleImage stretchableImageWithLeftCapWidth:11 topCapHeight:17];
            
            avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - AVATARXBUFFER/2.0f - AVATARPICWIDTH, YCELLBUFFER/2.0f, AVATARPICWIDTH,AVATARPICHEIGHT)];
            avatarImageView.image = self.avatarImage;
            
            textLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - AVATARPICWIDTH - AVATARXBUFFER - _size.width - XTEXTBUFFER, YCELLBUFFER/2.0f + YTEXTBUFFER/2.0f, _size.width,_size.height)];
            textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
            textLabel.text = self.text;
            textLabel.numberOfLines = 0;
            textLabel.backgroundColor = [UIColor clearColor];
            
            [self addSubview:textLabel];
            break;
        }
        case received:
        {
            bubbleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f, self.size.width + 3.0f * XTEXTBUFFER/2.0f, self.size.height + YTEXTBUFFER)];
            bubbleImageView.image = [self.bubbleImage stretchableImageWithLeftCapWidth:15 topCapHeight:17];
            
            avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(AVATARXBUFFER/2 , YCELLBUFFER/2, AVATARPICWIDTH,AVATARPICHEIGHT)];
            avatarImageView.image = self.avatarImage;
            
            textLabel = [[UILabel alloc] initWithFrame:CGRectMake(XTEXTBUFFER + AVATARPICWIDTH + AVATARXBUFFER, YCELLBUFFER/2.0f + YTEXTBUFFER/2.0f, _size.width,_size.height)];
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
    [self addSubview:bubbleImageView];
    [self addSubview:avatarImageView];
    [self addSubview:textLabel];
    
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
