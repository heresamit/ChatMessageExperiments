//
//  TDTTextImplementationsVC.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 06/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDTTextImplementationsVC : UITableViewController
@property (nonatomic,weak) NSMutableArray *messageArray;
-(void) parseData;

@end
