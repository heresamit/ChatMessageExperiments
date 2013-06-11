//
//  TDTCustomEmoticonsMenuVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 10/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCustomEmoticonsMenuVC.h"
#import "TDTWebViewData.h"
#import "TDTWebViewMethodVC.h"

@interface TDTCustomEmoticonsMenuVC ()
@property (nonatomic,strong) NSMutableDictionary *emoticonDict;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation TDTCustomEmoticonsMenuVC
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
        self.emoticonDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"happyEmoticon.png",    @":)",
                             @"sadEmoticon.png",      @":(",
                             @"testImg.png",          @"[]",
                             nil];
    }
    return self;
}

-(void) parseData
{
        for(int i = 0; i < self.messageArray.count;i++)
        [self.dataArray addObject:[[TDTWebViewData alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue] withEmoticonDict:self.emoticonDict]];
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"UIWebViewSegue"])
    {
        TDTWebViewMethodVC *dvc = (TDTWebViewMethodVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
}

@end