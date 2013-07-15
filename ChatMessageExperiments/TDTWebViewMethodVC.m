//
//  TDTWebViewMethodVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 10/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTWebViewMethodVC.h"
#import "TDTWebViewData.h"
#import "Constants.h"

@interface TDTWebViewMethodVC ()
@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;
//@property (nonatomic,strong) NSMutableDictionary *webViewCache;
@end

@implementation TDTWebViewMethodVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
//-(id) initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self)
//    {
//        _webViewCache = [[NSMutableDictionary alloc] init];
//    }
//    return self;
//}

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
    static NSString *CellIdentifier = @"WebViewCells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    TDTWebViewData *data = self.dataArray[indexPath.row];
    

    //----------------------------Code That Uses Webview of data Begins
    /*
    for(id view in cell.contentView.subviews)
        [view removeFromSuperview];
    
    if(data.isDirty)
    {
        data.temp.frame = (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfWebView.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height));
        data.isDirty = NO;
    }
    
    [cell.contentView addSubview:data.temp];
    */
    //----------------------------Code That Uses Webview of data Ends    
 /*
    //-----------------------------Caching code Begins
    for(id view in cell.contentView.subviews)
        [view removeFromSuperview];
    
    if(![self.webViewCache objectForKey:[NSNumber numberWithInt:indexPath.row]])
    {
        UIWebView *temp;
        temp = [[UIWebView alloc] initWithFrame:(data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfWebView.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height))];
        
        [temp loadData:data.htmlData MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        temp.scrollView.scrollEnabled = NO;
        temp.opaque = NO;
        temp.backgroundColor = [UIColor clearColor];
        [self.webViewCache setObject:temp forKey:[NSNumber numberWithInt:indexPath.row]];
        [cell.contentView addSubview:temp];
    }
    else
    {
        [cell.contentView addSubview:[self.webViewCache objectForKey:[NSNumber numberWithInt:indexPath.row]]];
    }
    //-----------------------------Caching code Ends
 */
    //-----------------------------Normal code Starts
    BOOL token = NO;
   
    for(id view in cell.contentView.subviews)
    {
        if ([view isKindOfClass:[UIWebView class]])
        {
            [view setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfWebView.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height))];
            [view loadData:data.htmlData MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
            token = YES;
        }
    }
    
    if(!token)
    {
        UIWebView *temp;
        temp = [[UIWebView alloc] initWithFrame:(data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfWebView.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfWebView.width, data.sizeOfWebView.height))];
        [temp loadData:data.htmlData MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];        temp.scrollView.scrollEnabled = NO;
        temp.opaque = NO;
        temp.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:temp];
        

    }
 //-----------------------------Normal code Ends
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

#pragma mark - Table view delegate

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TDTWebViewData *data = self.dataArray[indexPath.row];
    //NSLog(@"%f",data.sizeOfWebView.height + YCELLBUFFER);
    return data.sizeOfWebView.height + YCELLBUFFER;
}
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

@end
