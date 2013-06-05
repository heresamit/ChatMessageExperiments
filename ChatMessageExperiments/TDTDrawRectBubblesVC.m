//
//  TDTDrawRectBubblesVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTDrawRectBubblesVC.h"
#import "TDTBubbleData.h"
#import "TDTDrawnBubbleView.h"

@interface TDTDrawRectBubblesVC ()
@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;
@end

@implementation TDTDrawRectBubblesVC

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _sfc = [[TDTSkippedFrameCounter alloc] initWithDelegate:self];
    }
    return self;
}

-(void) updateSkippedFrames:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return !(toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UITableViewCell *tempCell;
    for (NSIndexPath *path in [self.tableView indexPathsForVisibleRows]) {
        tempCell = [self.tableView cellForRowAtIndexPath:path];
        for(TDTDrawnBubbleView *obj in tempCell.contentView.subviews)
        {
            if(obj.type == sent || obj.type == sentSelected)
            {
                if(toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && toInterfaceOrientation != UIInterfaceOrientationPortrait)
                    [obj shiftFrameForLandScape];
                else
                    [obj shiftFrameForPortrait];
            }
        }
    }
    
    
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
                                                   initWithTitle: @"Results (drawRect Bubbles)"
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
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"drawRectCells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    for (UIView *view in cell.contentView.subviews)
        [view removeFromSuperview];
       
    TDTBubbleData *data = self.dataArray[indexPath.row];
    
    TDTDrawnBubbleView *view = [[TDTDrawnBubbleView alloc] initWithFrame:CGRectZero withType:data.type withSize:data.sizeOfBubble];
    
    if(self.interfaceOrientation != UIInterfaceOrientationPortrait && (data.type == sent || data.type == sentSelected))
        [view shiftFrameForLandScape];
    else if(data.type == sent || data.type == sentSelected)
        [view shiftFrameForPortrait];
    
    [cell.contentView addSubview:view];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTBubbleData *data = self.dataArray[indexPath.row];
    return data.sizeOfBubble.height + YCELLBUFFER;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
