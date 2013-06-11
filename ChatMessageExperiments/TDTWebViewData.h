//
//  TDTWebViewData.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 10/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface TDTWebViewData : NSObject <UIWebViewDelegate>
@property (nonatomic) BOOL isDirty;
@property (nonatomic,weak) NSMutableDictionary* emoticonDict;
@property (nonatomic) TDTBubbleType type;
@property (nonatomic) CGSize sizeOfWebView;
@property (nonatomic,strong) NSString * HTMLString;
@property (nonatomic,strong) UIWebView * temp;
@property (nonatomic, strong) NSData* htmlData;

- (id)initWithText:(NSString *)text withType:(TDTBubbleType)type withEmoticonDict:(NSMutableDictionary *)emoticonDict;
@end
