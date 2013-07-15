//
//  TDTCellData.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 27/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCellData.h"

@implementation TDTCellData

- (id)initWithUnselectedAttributedString:(NSAttributedString *)attrStr selectedAttributedString:(NSAttributedString *)selAttrStr size:(CGSize)size type:(TDTBubbleType)type hasLinks:(BOOL)hasLinks {
    self = [super init];
    if (self) {
        _attrStr = [[NSAttributedString alloc] initWithAttributedString:attrStr];
        _selAttrStr = [[NSAttributedString alloc] initWithAttributedString:selAttrStr];
        _textSize = size;
        _type = type;
        _hasLinks = hasLinks;
    }
    return self;
}

@end
