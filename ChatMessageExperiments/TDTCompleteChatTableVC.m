//
//  TDTCompleteChatTableVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 26/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTCompleteChatTableVC.h"
#import "TDTSkippedFrameCounter.h"
#import <OHAttributedLabel/OHAttributedLabel.h>
#import "Constants.h"
#import "TDTCellData.h"
#import "TDTSentMessageCustomView.h"
#import "TDTReceivedMessageCustomView.h"

@interface TDTCompleteChatTableVC ()

@property (nonatomic,strong) TDTSkippedFrameCounter* sfc;
@property (nonatomic) double time;
@property (nonatomic, strong) NSCharacterSet *emoticonSet;
@property (nonatomic, strong) UIFont *textFont, *emoticonFont;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, weak) TDTCellData *data;
@property (nonatomic, strong) NSDictionary *unselectedAttributes;
@property (nonatomic, strong) NSDictionary *selectedAttributes;
@property (nonatomic, strong) NSDictionary *emoticonSubstringAttributes;
@property (nonatomic, strong) id bubblePicSent;
@property (nonatomic, strong) id avatarPicSent;
@property (nonatomic, strong) id bubblePicRec;
@property (nonatomic, strong) id bubblePicRecSelected;
@property (nonatomic, strong) id bubblePicSentSelected;
@property (nonatomic, strong) id avatarPicRec;
@property (nonatomic) CGSize sentBubblePicSize;
@property (nonatomic) CGSize recBubblePicSize;
@property (nonatomic, strong) NSMutableParagraphStyle *paragraphStyle;

@end

@implementation TDTCompleteChatTableVC

-(CGSize)sizeForAttributedString:(NSAttributedString *)attrString
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attrString);
    CGSize targetSize = CGSizeMake(MAXTEXTWIDTH, MAXFLOAT);
    CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attrString length]), NULL, targetSize, NULL);
    
    CFRelease(framesetter);
    fitSize = CGSizeMake(ceil(fitSize.width), ceil(fitSize.height + 1
                                                   //+ lineSpacingFactor
                                                   ));
    return fitSize;
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
    [self parseData];
}

- (NSDictionary *)createCustomAttributedStringFromString:(NSString *)string {
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:self.unselectedAttributes];
    NSMutableAttributedString *selectedAttrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:self.selectedAttributes];
    NSNumber *hasLinks;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber error:nil];
    NSUInteger numberOfMatches = [detector numberOfMatchesInString:string options:0 range:NSMakeRange(0, [string length])];
    if (!numberOfMatches) {
        hasLinks = [NSNumber numberWithBool:NO];
    }
    else {
        hasLinks = [NSNumber numberWithBool:YES];
    }
    // 12-14 and 40-42 FPS With OHAttributedLabels for all cells.
    // 24-26 and 52-55 FPS With CATextLayer for all cells.
    NSScanner *scanner = [NSScanner scannerWithString:string];
    while (![scanner isAtEnd]) {
        [scanner scanUpToCharactersFromSet:self.emoticonSet intoString:NULL]; 
        NSString *temp;
        NSUInteger location = [scanner scanLocation];
        if ([scanner scanCharactersFromSet:self.emoticonSet intoString:&temp]) {
            [attrStr setAttributes:_emoticonSubstringAttributes range:NSMakeRange(location, [temp length])];
            [selectedAttrStr setAttributes:_emoticonSubstringAttributes range:NSMakeRange(location, [temp length])];
        }
    }
    return @{@"selectedAttrStr": selectedAttrStr, @"unselectedAttrStr":attrStr,@"hasLinks":hasLinks,};
}

- (void)parseData
{
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //seconds
    lpgr.delegate = self;
    [self.tableView addGestureRecognizer:lpgr];
    
    _textFont = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    _emoticonFont = [UIFont fontWithName:@"TDTCustomFont" size:12.0f];
    _dataArray = [[NSMutableArray alloc] initWithCapacity:self.messageArray.count];
    
    _paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    _paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    _paragraphStyle.alignment = NSTextAlignmentLeft;
    _paragraphStyle.lineSpacing = 1;
  
  
//    _paragraphStyle.lineHeightMultiple = 0.5f;
//    _paragraphStyle.maximumLineHeight = MAX(_textFont.pointSize, _emoticonFont.pointSize);
//    _paragraphStyle.minimumLineHeight = MIN(_textFont.pointSize, _emoticonFont.pointSize);

    _unselectedAttributes = @{NSFontAttributeName: _textFont,NSParagraphStyleAttributeName: _paragraphStyle, };
    _selectedAttributes = @{NSFontAttributeName: _textFont,NSParagraphStyleAttributeName: _paragraphStyle,
                            (id)kCTForegroundColorAttributeName:(id)[UIColor whiteColor].CGColor,};
    _emoticonSubstringAttributes = @{NSFontAttributeName: self.emoticonFont,NSParagraphStyleAttributeName:_paragraphStyle,};
    
    _recBubblePicSize = [UIImage imageNamed:@"chat-bubble-incoming.png"].size;
    _bubblePicRec = (__bridge id)([UIImage imageNamed:@"chat-bubble-incoming.png"].CGImage);
    _avatarPicRec = (__bridge id)[UIImage imageNamed:@"avatarPlaceHolder.png"].CGImage;
    
    _sentBubblePicSize = [UIImage imageNamed:@"chat-bubble-outgoing.png"].size;
    _bubblePicSent = (__bridge id)[UIImage imageNamed:@"chat-bubble-outgoing.png"].CGImage;
    _avatarPicSent = (__bridge id)([UIImage imageNamed:@"avatarPlaceHolder.png"].CGImage);
    
    _bubblePicRecSelected = (__bridge id)[UIImage imageNamed:@"chat-bubble-incoming-highlighted.png"].CGImage;
    _bubblePicSentSelected = (__bridge id)[UIImage imageNamed:@"chat-bubble-outgoing-highlighted.png"].CGImage;
    
    NSString *emoticonString = @"";
    for (unichar ch = 0xE600; ch <= 0xE61B; ch++) {
        emoticonString = [emoticonString stringByAppendingFormat:@"%C", ch];
    }
    self.emoticonSet = [NSCharacterSet characterSetWithCharactersInString:emoticonString];
    for(int i = 0; i < self.messageArray.count;i++) {
        NSDictionary *temp = [self createCustomAttributedStringFromString:self.messageArray[i][1]];
        [self.dataArray addObject:[[TDTCellData alloc] initWithUnselectedAttributedString:[temp objectForKey:@"unselectedAttrStr"]
                                                                 selectedAttributedString:[temp objectForKey:@"selectedAttrStr"]
                                                                                 size:[self sizeForAttributedString:[temp objectForKey:@"unselectedAttrStr"]]
                                                                                 type:[self.messageArray[i][0] boolValue]
                                                                                 hasLinks:[[temp objectForKey:@"hasLinks"] boolValue]]];
        
    }

//        CGSize bubblePicSize = [UIImage imageNamed:@"chat-bubble-outgoing.png"].size;
//        _bubbleLayerSent = [[CALayer alloc] init];
//        _bubbleLayerSent.contents = (__bridge id)[UIImage imageNamed:@"chat-bubble-outgoing.png"].CGImage;
//        _bubbleLayerSent.contentsScale = [UIScreen mainScreen].scale;
//        _bubbleLayerSent.contentsCenter = CGRectMake(
//                                                  11.0f/bubblePicSize.width,
//                                                  17.0f/bubblePicSize.height,
//                                                  (bubblePicSize.width - 24.0f)
//                                                  /bubblePicSize.width
//                                                  , (bubblePicSize.height - 28.0f)
//                                                  /bubblePicSize.height
//                                                  );
//        _bubbleLayerSent.opaque = YES;
//        _bubbleLayerSent.name = @"BS";
//    
//        _avatarLayerSent = [[CALayer alloc] init];
//        _avatarLayerSent.contents = (__bridge id)[UIImage imageNamed:@"avatarPlaceHolderMe.png"].CGImage;
//        _avatarLayerSent.name = @"AS";
//    
//    
//        bubblePicSize = [UIImage imageNamed:@"chat-bubble-incoming.png"].size;
//        _bubbleLayerRec.contents = (__bridge id)[UIImage imageNamed:@"chat-bubble-incoming.png"].CGImage;
//        _bubbleLayerRec.contentsScale = [UIScreen mainScreen].scale;
//        _bubbleLayerRec.contentsCenter = CGRectMake(
//                                                  15.0f/bubblePicSize.width,
//                                                  17.0f/bubblePicSize.height,
//                                                  (bubblePicSize.width - 30.0f)
//                                                  /bubblePicSize.width
//                                                  , (bubblePicSize.height - 28.0f)
//                                                  /bubblePicSize.height
//                                                  );
//        _bubbleLayerRec.opaque = YES;
//        _bubbleLayerRec.name = @"BR";
//    
//        _avatarLayerRec = [[CALayer alloc] init];
//        _avatarLayerRec.frame = CGRectMake(AVATARXBUFFER/2 , YCELLBUFFER/2, AVATARPICWIDTH,AVATARPICHEIGHT);
//        _avatarLayerRec.contents = (__bridge id)[UIImage imageNamed:@"avatarPlaceHolder.png"].CGImage;
//        _avatarLayerRec.name = @"AR";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UITableViewCell *tempCell;
    for (NSIndexPath *path in [self.tableView indexPathsForVisibleRows]) {
        tempCell = [self.tableView cellForRowAtIndexPath:path];
        for(id obj in tempCell.contentView.subviews)
        {
            if([obj isKindOfClass:[TDTSentMessageCustomView class]])
            {
                if(toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown && toInterfaceOrientation != UIInterfaceOrientationPortrait)
                    [obj shiftFrameForLandScape];
                else
                    [obj shiftFrameForPortrait];
            }
        }
    }
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _data = self.dataArray[indexPath.row];
    static NSString *CellIdentifierSent = @"FullCellSent";
    static NSString *CellIdentifierRec = @"FullCellRec";
    UITableViewCell *cell;
    TDTSentMessageCustomView *customSentView;
    TDTReceivedMessageCustomView *customReceivedView;
    BOOL token = NO;
    if (_data.type == sent) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierSent];
        for (TDTSentMessageCustomView* view in cell.contentView.subviews) {
            if ([view isKindOfClass:[TDTSentMessageCustomView class]]) {
                [view updateCustomViewWithAttributedText:_data.attrStr size:_data.textSize hasLinks:_data.hasLinks inPortrait:(self.interfaceOrientation == UIInterfaceOrientationPortrait)];
                token = YES;
            }
        }
       if (!token) {
           customSentView = [[TDTSentMessageCustomView alloc] initWithAttributedText:_data.attrStr attributedTextBoundingRect:_data.textSize avatarPic:_avatarPicSent bubblePic:_bubblePicSent bubblePicSize:_sentBubblePicSize hasLinks:_data.hasLinks inPortrait:(self.interfaceOrientation == UIInterfaceOrientationPortrait)];
            [cell.contentView addSubview:customSentView];
       }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierRec];     
        for (id view in cell.contentView.subviews) {
            if ([view isKindOfClass:[TDTReceivedMessageCustomView class]]) {
                [view updateCustomViewWithAttributedText:_data.attrStr size:_data.textSize hasLinks:_data.hasLinks];
                token = YES;
            }
        }
        if (!token) {
        customReceivedView = [[TDTReceivedMessageCustomView alloc] initWithAttributedText:_data.attrStr attributedTextBoundingRect:_data.textSize avatarPic:_avatarPicRec bubblePic:_bubblePicRec bubblePicSize:_recBubblePicSize hasLinks:_data.hasLinks];
        [cell.contentView addSubview:customReceivedView];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataArray[indexPath.row] textSize].height + YCELLBUFFER + YTEXTBUFFER;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    //NSLog(@" ");
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
        TDTCellData *data = self.dataArray[indexPath.row];
        UITableViewCell *temp = [self.tableView cellForRowAtIndexPath:indexPath];
        for (id view in temp.contentView.subviews) {
            if ([view isKindOfClass:[TDTSentMessageCustomView class]] || [view isKindOfClass:[TDTReceivedMessageCustomView class]]) {
                if (![view isSelected]) {
                    if (!data.hasLinks) {
                        [view textLayer].string = [data selAttrStr];
                    }
                    else {
                        [view textLabel].attributedText = [data selAttrStr];
                    }
                    if (data.type == sent) {
                        [view bubbleLayer].contents = _bubblePicSentSelected;
                    }
                    else {
                        [view bubbleLayer].contents = _bubblePicRecSelected;
                    }
                    [view setIsSelected:YES];
                }
                else {
                    if (!data.hasLinks) {
                        [view textLayer].string = [data attrStr];
                    }
                    else {
                        [view textLabel].attributedText = [data attrStr];
                    }
                    if (data.type == sent) {
                        [view bubbleLayer].contents = _bubblePicSent;
                    }
                    else {
                        [view bubbleLayer].contents = _bubblePicRec;
                    }
                    [view setIsSelected:NO];
                }
            }
        }
        
    }
    
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
                                                   initWithTitle: @"Results (CALayer Bubbles, Avatar & text)"
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
