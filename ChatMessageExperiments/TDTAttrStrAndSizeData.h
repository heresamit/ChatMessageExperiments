//
//  TDTAttrStrAndSizeData.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 25/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface TDTAttrStrAndSizeData : NSObject

@property (nonatomic, strong) NSAttributedString *attrStr;
@property (nonatomic) CGSize textSize;
@property (nonatomic) TDTBubbleType type;

- (id)initWithAttributedString:(NSAttributedString *)attrStr withSize:(CGSize)size withType:(TDTBubbleType)type;

@end
