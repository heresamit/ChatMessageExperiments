//
//  TDTAttrStrAndSizeData.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 25/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTAttrStrAndSizeData.h"

@implementation TDTAttrStrAndSizeData

- (id)initWithAttributedString:(NSAttributedString *)attrStr withSize:(CGSize)size withType:(TDTBubbleType)type{
    self = [super init];
    if (self) {
        _attrStr = [[NSAttributedString alloc] initWithAttributedString:attrStr];
        _textSize = size;
        _type = type;
    }
    return self;
}

@end
