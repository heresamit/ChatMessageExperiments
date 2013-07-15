//
//  TDTCustomFontImplementationsVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 25/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCustomFontImplementationsVC.h"
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "Constants.h"
#import "TDTAttrStrAndSizeData.h"
#import "TDTOHAttributedLabelMethodVC.h"
#import "TDTNSAttributedStringMethodVC.h"
#import "TDTDTCoreTextMethodVC.h"

@interface TDTCustomFontImplementationsVC ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSCharacterSet *emoticonSet;
@property (nonatomic, strong) UIFont *textFont, *emoticonFont;

@end

@implementation TDTCustomFontImplementationsVC

- (NSAttributedString *)createCustomAttributedStringFromString:(NSString *)string {
    NSDictionary *attributes = @{NSFontAttributeName: self.textFont,};
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:self.emoticonSet intoString:NULL];
        NSString *temp;
        NSUInteger location = [scanner scanLocation];
        if ([scanner scanCharactersFromSet:self.emoticonSet intoString:&temp]) {
            [attrStr setAttributes:@{NSFontAttributeName: self.emoticonFont,} range:NSMakeRange(location, [temp length])];
        }
    }
    return [attrStr copy];
}

-(void) parseData
{
    self.textFont = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    self.emoticonFont = [UIFont fontWithName:@"TDTEmoFull" size:12.0f];
    NSString *emoticonString = @"";
    for (unichar ch = 0xE600; ch <= 0xE61B; ch++) {
        emoticonString = [emoticonString stringByAppendingFormat:@"%C", ch];
    }
    self.emoticonSet = [NSCharacterSet characterSetWithCharactersInString:emoticonString];
    OHAttributedLabel *labelOH = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(0, 0, MAXTEXTWIDTH, 100)];
    _dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
    for(int i = 0; i < self.messageArray.count;i++) {
        labelOH.attributedText = [self createCustomAttributedStringFromString:self.messageArray[i][1]];
        [self.dataArray addObject:[[TDTAttrStrAndSizeData alloc] initWithAttributedString:labelOH.attributedText withSize:[labelOH sizeThatFits:CGSizeMake(MAXTEXTWIDTH, 99999)] withType:[self.messageArray[i][0] boolValue]]];
    }
        //[self.dataArray addObject:[[TDTBubbleDataWithText alloc] initWithText:self.messageArray[i][1] withType:[self.messageArray[i][0] boolValue]]];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"OHAttributedLabelSegue"])
    {
        TDTOHAttributedLabelMethodVC *dvc = (TDTOHAttributedLabelMethodVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    else if([[segue identifier] isEqualToString:@"NSAttributedStringSegue"])
    {
        TDTNSAttributedStringMethodVC *dvc = (TDTNSAttributedStringMethodVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
    else if([[segue identifier] isEqualToString:@"DTCoreSegue"])
    {
        TDTDTCoreTextMethodVC *dvc = (TDTDTCoreTextMethodVC *)[segue destinationViewController];
        dvc.dataArray = self.dataArray;
    }
}

@end
