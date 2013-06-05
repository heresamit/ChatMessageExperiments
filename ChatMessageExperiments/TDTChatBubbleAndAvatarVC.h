//
//  TDTChatBubbleAndAvatarVC.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDTChatBubbleAndAvatarVC : UITableViewController
@property (nonatomic,weak) NSMutableArray *messageArray;
-(void) parseData;
@end
