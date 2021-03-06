//
//  TDTBubbleImplementationsMenuViewController.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTBubbleImplementationsMenuViewController.h"
#import "TDTDrawRectBubblesVC.h"
#import "TDTLayerBubblesVC.h"
#import "TDTImageBubblesVC.h"
#import "TDTBubbleData.h"

@interface TDTBubbleImplementationsMenuViewController ()
@property (nonatomic, strong) NSMutableArray* dataArray;
@end

@implementation TDTBubbleImplementationsMenuViewController

-(void) parseData
{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
    for(int i = 0; i < self.messageArray.count;i++)
        [self.dataArray addObject:[[TDTBubbleData alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue]]];
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"drawRectMethodSegue"])
    {
        TDTDrawRectBubblesVC *dvc = (TDTDrawRectBubblesVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
        //dvc.messageArray = self.messageArray;
        //parse Some data there?
    }
    
    else if([[segue identifier] isEqualToString:@"layerMethodSegue"])
    {
        TDTLayerBubblesVC *dvc = (TDTLayerBubblesVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    else if([[segue identifier] isEqualToString:@"imageMethodSegue"])
    {
        TDTImageBubblesVC *dvc = (TDTImageBubblesVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    
}

@end
