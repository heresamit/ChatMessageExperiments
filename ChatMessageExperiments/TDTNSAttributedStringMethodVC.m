//
//  TDTNSAttributedStringMethodVCViewController.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 25/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTNSAttributedStringMethodVC.h"
#import "TDTSkippedFrameCounter.h"
#import "Constants.h"
#import "TDTAttrStrAndSizeData.h"

@interface TDTNSAttributedStringMethodVC ()

@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;

@end

@implementation TDTNSAttributedStringMethodVC

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
    static NSString *CellIdentifier = @"NSAttributedStringCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    TDTAttrStrAndSizeData *data = self.dataArray[indexPath.row];
    UILabel *labelOH;
    BOOL token = NO;
    
    for(id view in cell.contentView.subviews)
    {
        if ([view isKindOfClass:[UILabel class]]) {
            [view setAttributedText:data.attrStr];
            [view setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.textSize.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height))];
            token = YES;
        }
    }
    
    if(!token)
    {
        labelOH = [[UILabel alloc] init];
        labelOH.attributedText = data.attrStr;
        labelOH.backgroundColor = [UIColor clearColor];
        [labelOH setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.textSize.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.textSize.width, data.textSize.height))];
        labelOH.numberOfLines = 0;
        [cell.contentView addSubview:labelOH];
    }
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] textSize].height + YCELLBUFFER;
}


@end
