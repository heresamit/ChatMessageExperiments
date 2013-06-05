//
//  TDTChatBubbleAndAvatarVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 05/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTChatBubbleAndAvatarVC.h"
#import "TDTBubbleData.h"
#import "TDTLayerBubblesAndAvatarVC.h"
#import "TDTImageBubblesAndAvatarVC.h"

@interface TDTChatBubbleAndAvatarVC ()
@property (nonatomic, strong) NSMutableArray* dataArray;
@end

@implementation TDTChatBubbleAndAvatarVC

-(void) parseData
{
    _dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
    for(int i = 0; i < self.messageArray.count;i++)
        [self.dataArray addObject:[[TDTBubbleData alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue]]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"LayerMethodSegue"])
    {
        TDTLayerBubblesAndAvatarVC *dvc = (TDTLayerBubblesAndAvatarVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    if([[segue identifier] isEqualToString:@"ImageMethodSegue"])
    {
        TDTImageBubblesAndAvatarVC *dvc = (TDTImageBubblesAndAvatarVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
}
@end
