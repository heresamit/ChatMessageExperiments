//
//  TDTWebViewMethodVC.h
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 10/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDTSkippedFrameCounter.h"
@interface TDTWebViewMethodVC : UITableViewController <TDTskippedFrameCounterProtocol>
@property (nonatomic, weak) NSMutableArray *dataArray;
@end
