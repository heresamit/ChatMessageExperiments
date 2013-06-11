//
//  TDTTextImplementationsVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 06/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTTextImplementationsVC.h"
#import "TDTBubbleDataWithText.h"
#import "TDTCALayerTextVC.h"
#import "TDTDrawRectTextVC.h"
#import "TDTUILabelTextVC.h"

@interface TDTTextImplementationsVC ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation TDTTextImplementationsVC


-(void) parseData
{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
    for(int i = 0; i < self.messageArray.count;i++)
        [self.dataArray addObject:[[TDTBubbleDataWithText alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue]]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"drawRectSegue"])
    {
        TDTDrawRectTextVC *dvc = (TDTDrawRectTextVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    else if([[segue identifier] isEqualToString:@"UILabelSegue"])
    {
        TDTUILabelTextVC *dvc = (TDTUILabelTextVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    else if([[segue identifier] isEqualToString:@"CATextLayerSegue"])
    {
        TDTCALayerTextVC *dvc = (TDTCALayerTextVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
}@end
