//
//  TDTBubbleDataWithText.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface TDTBubbleDataWithText : NSObject

@property (nonatomic) CGSize sizeOfBubble;
@property (nonatomic) TDTBubbleType type;
@property (nonatomic, strong) NSString* text;

- (id)initWithText:(NSString *)text withType:(TDTBubbleType)type;

@end
