//
//  TDTDTCoreTextMethodVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 25/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTDTCoreTextMethodVC.h"
#import "TDTSkippedFrameCounter.h"
#import "TDTAttrStrAndSizeData.h"
#import "DTCoreText.h"

@interface TDTDTCoreTextMethodVC ()

@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;

@end

@implementation TDTDTCoreTextMethodVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _sfc = [[TDTSkippedFrameCounter alloc] initWithDelegate:self];
    }
    return self;
}

-(void) updateSkippedFrames:(int)toDisplay
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d",toDisplay];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TDTDTCoreTextMethodCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    TDTAttrStrAndSizeData *data = self.dataArray[indexPath.row];
    DTAttributedLabel *labelOH;
    BOOL token = NO;
    
    for(id view in cell.contentView.subviews)
    {
        if ([view isKindOfClass:[DTAttributedLabel class]]) {
            [view setAttributedString:data.attrStr];
            [view setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.textSize.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height))];
            token = YES;
        }
    }
    
    if(!token)
    {
        labelOH = [[DTAttributedLabel alloc] init];
        labelOH.attributedString = data.attrStr;
        labelOH.backgroundColor = [UIColor clearColor];
        [labelOH setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.textSize.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height))];
        [cell.contentView addSubview:labelOH];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] textSize].height + YCELLBUFFER;
}

@end
