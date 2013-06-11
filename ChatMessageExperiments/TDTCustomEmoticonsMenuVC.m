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
#import "TDTDTAttributedTextViewVC.h"
#import "DTCoreText.h"

@interface TDTCustomEmoticonsMenuVC ()
@property (nonatomic,strong) NSMutableDictionary *emoticonDict;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *attributedStringArray;
@property (nonatomic,strong) NSDictionary *builderOptions;
@property (nonatomic,strong) DTAttributedLabel *tempLabel;
@end

@implementation TDTCustomEmoticonsMenuVC

-(void) calculateAttributedStringArray
{
    
}
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
        self.attributedStringArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
        self.emoticonDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"happyEmoticon.png",    @":)",
                             @"sadEmoticon.png",      @":(",
                             @"testImg.png",          @"[]",
                             nil];
         self.builderOptions = @{
                                         DTDefaultFontFamily: @"Helvetica",
                                         DTDefaultFontSize:@15,
                                         
                                         };
        self.tempLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, MAXTEXTWIDTH, 10)];
        self.tempLabel.layoutFrameHeightIsConstrainedByBounds = NO;
    }
    return self;
}

-(void) parseData
{
        for(int i = 0; i < self.messageArray.count;i++)
        {
            [self.dataArray addObject:[[TDTWebViewData alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue] withEmoticonDict:self.emoticonDict]];
        }
        for(int i = 0; i < self.dataArray.count;i++)
        {

            NSAttributedString *temp = [[[DTHTMLAttributedStringBuilder alloc] initWithHTML:[self.dataArray[i] htmlData]
                                                                                    options:self.builderOptions
                                                                         documentAttributes:nil]
                                        generatedAttributedString];
            [self.attributedStringArray addObject:temp];
            //NSLog(@"%@",temp);
            self.tempLabel.attributedString = temp;
            CGSize tempSize = [self.tempLabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:MAXTEXTWIDTH];
            [self.dataArray[i] setSizeOfWebView:tempSize];
//            NSLog(self.tempLabel.attributedString.string);
            //NSLog(@"%@",[NSValue valueWithCGSize:tempSize]);
           
        }

}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"UIWebViewSegue"])
    {
        TDTWebViewMethodVC *dvc = (TDTWebViewMethodVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    if([[segue identifier] isEqualToString:@"DTAttributedTextViewSegue"])
    {
        TDTDTAttributedTextViewVC *dvc = (TDTDTAttributedTextViewVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
        dvc.attributedStringArray = self.attributedStringArray;
    }
}
@end