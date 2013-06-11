//
//  TDTDrawRectTextVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 06/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTDrawRectTextVC.h"
#import "TDTBubbleDataWithText.h"

@interface TDTDrawRectTextVC ()
@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;
@end

@implementation TDTDrawRectTextVC

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        _sfc = [[TDTSkippedFrameCounter alloc] initWithDelegate:self];
    return self;
}

-(void) updateSkippedFrames:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"drCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    // Configure the cell...
    
    return cell;
}

-(void) viewDidAppear:(BOOL)animated
{
    _time = CFAbsoluteTimeGetCurrent();
    [self scrollAutomatically:0];
}

-(void) scrollAutomatically:(int) i
{
    __block int j = i;
    [UIView animateWithDuration: .002
                     animations: ^{
                         [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:j inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                     }completion: ^(BOOL finished){
                         j = j + 10;
                         //NSLog(@"%d",i);
                         if(j<=2999)
                             [self scrollAutomatically:j];
                         else
                         {
                             double temp = CFAbsoluteTimeGetCurrent() - _time;
                             UIAlertView *alert = [[UIAlertView alloc]
                                                   initWithTitle: @"Results (drawn text)"
                                                   message: [NSString stringWithFormat:@"It took %.3f seconds to scroll %d messages (if Back wasn't pressed) and %@ frames were skipped.\nRow index was incremented by 10 after every 0.002 seconds in this run.",temp,j,self.navigationItem.title]//@""
                                                   delegate: nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
                             [alert show];
                             NSLog(@"%f",temp);
                         }
                     }
     ];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTBubbleDataWithText *data = self.dataArray[indexPath.row];
    return data.sizeOfBubble.height + YCELLBUFFER;
}
@end
