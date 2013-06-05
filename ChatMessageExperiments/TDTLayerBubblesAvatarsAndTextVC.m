//
//  TDTLayerBubblesAvatarsAndTextVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTLayerBubblesAvatarsAndTextVC.h"
#import "TDTBubbleDataWithText.h"
#import "TDTLayerBubbleAvatarAndTextView.h"

@interface TDTLayerBubblesAvatarsAndTextVC ()
@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic,strong) UIImage *bubbleImageSent;
@property (nonatomic,strong) UIImage *bubbleImageReceived;
@property (nonatomic,strong) UIImage *avatar1;
@property (nonatomic,strong) UIImage *avatar2;
@property (nonatomic) double time;
@end

@implementation TDTLayerBubblesAvatarsAndTextVC


-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _sfc = [[TDTSkippedFrameCounter alloc] initWithDelegate:self];
        _bubbleImageReceived  = [UIImage imageNamed:@"chat-bubble-incoming.png"];
        _bubbleImageSent = [UIImage imageNamed:@"chat-bubble-outgoing.png"];
        _avatar1 = [UIImage imageNamed:@"avatarPlaceHolder.png"];
        _avatar2 = [UIImage imageNamed:@"avatarPlaceHolderMe.png"];
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
        for(TDTLayerBubbleAvatarAndTextView *obj in tempCell.contentView.subviews)
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
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LayerMethodCells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    for (UIView *view in cell.contentView.subviews)
        [view removeFromSuperview];
    
    TDTBubbleDataWithText *data = self.dataArray[indexPath.row];
    
    TDTLayerBubbleAvatarAndTextView *view = [[TDTLayerBubbleAvatarAndTextView alloc] initWithFrame:CGRectZero withType:data.type withSize:data.sizeOfBubble withBubbleImage:((data.type == sent)? self.bubbleImageSent:self.bubbleImageReceived) withAvatarImage:((data.type == sent)? self.avatar1:self.avatar2) withText:data.text];
    
    if(self.interfaceOrientation != UIInterfaceOrientationPortrait && (data.type == sent || data.type == sentSelected))
        [view shiftFrameForLandScape];
    else if(data.type == sent || data.type == sentSelected)
        [view shiftFrameForPortrait];
    
    [cell.contentView addSubview:view];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTBubbleDataWithText *data = self.dataArray[indexPath.row];
    return MAX(AVATARPICHEIGHT,data.sizeOfBubble.height) + YCELLBUFFER;
}

#pragma mark - Table view delegate

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
                                                   initWithTitle: @"Results (CALayer Bubbles, Avatar & text)"
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

@end
