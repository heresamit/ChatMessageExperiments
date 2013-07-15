//
//  TDTCompleteChatTableVC.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 26/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDTCompleteChatTableVC : UITableViewController <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray* messageArray;

- (void)parseData;

@end
