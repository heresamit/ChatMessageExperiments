//
//  TDTCellData.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 27/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface TDTCellData : NSObject

@property (nonatomic, strong) NSAttributedString *attrStr;
@property (nonatomic, strong) NSAttributedString *selAttrStr;
@property (nonatomic) CGSize textSize;
@property (nonatomic) TDTBubbleType type;
@property (nonatomic) BOOL hasLinks;

- (id)initWithUnselectedAttributedString:(NSAttributedString *)attrStr selectedAttributedString:(NSAttributedString *)selAttrStr size:(CGSize)size type:(TDTBubbleType)type hasLinks:(BOOL)hasLinks;

@end
