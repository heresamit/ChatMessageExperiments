//
//  TDTCALayerTextVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 06/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCALayerTextVC.h"
#import "TDTBubbleDataWithText.h"

@interface TDTCALayerTextVC ()
@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;
@property (nonatomic,strong) NSDictionary *actionsDict;
@end

@implementation TDTCALayerTextVC

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
        _sfc = [[TDTSkippedFrameCounter alloc] initWithDelegate:self];
        _actionsDict = [[NSDictionary alloc]initWithObjectsAndKeys:
                   [NSNull null], @"onOrderIn",
                   [NSNull null], @"onOrderOut",
                   [NSNull null], @"sublayers",
                   [NSNull null], @"contents",
                   [NSNull null], @"bounds",
                   nil];
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
    static NSString *CellIdentifier = @"layerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell.contentView.layer setActions : self.actionsDict ];
    TDTBubbleDataWithText *data = self.dataArray[indexPath.row];
    BOOL token = NO;
    
    for (id layer in cell.contentView.layer.sublayers)
    {
        if ([layer isKindOfClass:[CATextLayer class]])
        {
            
            [CATransaction begin];
            [CATransaction setDisableActions:YES];
            
            [layer setString: data.text];
            [layer setFrame: (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfBubble.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height))];
            [CATransaction commit];
            
            token = YES;
        }
    }
    if(!token)
    {
        CATextLayer *textLayer = [[CATextLayer alloc] init];
        textLayer.actions = self.actionsDict;
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        textLayer.wrapped = YES;
        [textLayer setFont:@"Helvetica Neue"];
        [textLayer setFontSize:15.0f];
        [textLayer setForegroundColor:[[UIColor blackColor] CGColor]];
        textLayer.string = data.text;
        //[textLayer setAlignmentMode:kCAAlignmentLeft];
        textLayer.frame = (data.type == sent ? CGRectMake(cell.contentView.frame.size.width - data.sizeOfBubble.width - XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height):CGRectMake(XTEXTBUFFER, YCELLBUFFER/2.0f, data.sizeOfBubble.width, data.sizeOfBubble.height));
            [cell.contentView.layer addSublayer:textLayer];
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
                                                   initWithTitle: @"Results (CALayer Text)"
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
