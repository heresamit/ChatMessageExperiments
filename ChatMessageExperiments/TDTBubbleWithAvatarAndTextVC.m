//
//  TDTBubbleWithAvatarAndTextVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTBubbleWithAvatarAndTextVC.h"
#import "TDTBubbleDataWithText.h"
#import "TDTLayerBubblesAvatarsAndTextVC.h"
#import "TDTImageBubblesAvatarsAndTextVC.h"

@interface TDTBubbleWithAvatarAndTextVC ()
@property (nonatomic, strong) NSMutableArray* dataArray;
@end

@implementation TDTBubbleWithAvatarAndTextVC

-(void) parseData
{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
    for(int i = 0; i < self.messageArray.count;i++)
        [self.dataArray addObject:[[TDTBubbleDataWithText alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue]]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"LayerMethodSegue"])
    {
        TDTLayerBubblesAvatarsAndTextVC *dvc = (TDTLayerBubblesAvatarsAndTextVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    else if([[segue identifier] isEqualToString:@"ImageMethodSegue"])
    {
        TDTImageBubblesAvatarsAndTextVC *dvc = (TDTImageBubblesAvatarsAndTextVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
}
@end
