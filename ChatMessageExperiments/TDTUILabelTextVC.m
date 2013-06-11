//
//  TDTUILabelTextVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 06/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTUILabelTextVC.h"
#import "TDTBubbleDataWithText.h"

@interface TDTUILabelTextVC ()
@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;
@end

@implementation TDTUILabelTextVC
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
    static NSString *CellIdentifier = @"labelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UILabel *textLabel;
    TDTBubbleDataWithText *data = self.dataArray[indexPath.row];
    BOOL token = NO;

    for(id view in cell.contentView.subviews)
    {
        if ([view isKindOfClass:[UILabel class]]) {
            [view setText:data.text];
            [view setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfBubble.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height))];
            token = YES;
        }
    }
    
    if(!token)
    {
        textLabel = [[UILabel alloc] init];
        textLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15.0f];
        textLabel.text = data.text;
        textLabel.numberOfLines = 0.0f;
        textLabel.backgroundColor = [UIColor clearColor];
        [textLabel setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfBubble.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height))];
        
        [cell.contentView addSubview:textLabel];
    }
  

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
                                                   initWithTitle: @"Results (UILabel text)"
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
