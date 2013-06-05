//
//  TDTBubbleData.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTBubbleData.h"

@implementation TDTBubbleData

- (id)initWithText:(NSString *)text withType:(TDTBubbleType)type
{
    self = [super init];
    if(self)
    {
        _sizeOfBubble = [text sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15.0f] constrainedToSize:CGSizeMake(MAXTEXTWIDTH,INFINITY)  lineBreakMode:NSLineBreakByWordWrapping];
        _type = type;
    }
    return self;
}
@end
