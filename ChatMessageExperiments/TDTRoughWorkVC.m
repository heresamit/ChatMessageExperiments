//
//  TDTRoughWorkVC.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 10/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTRoughWorkVC.h"
#import "Constants.h"
#import "DTCoreText.h"
#import <malloc/malloc.h>
#import <objc/runtime.h>
#import <OHAttributedLabel/OHAttributedLabel.h>

@interface TDTRoughWorkVC ()
@property (nonatomic, strong) NSMutableDictionary * emoticonDict;
@property (nonatomic, strong) NSString *myHTML;
@property (nonatomic, strong) NSCharacterSet *emoticonSet;
@end

@implementation TDTRoughWorkVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.emoticonDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"happyEmoticon.png",    @":)",
//                         @"sadEmoticon.png",            @":(",
//                         @"testImg.png",                @"[]",
//                         nil];
//    self.myHTML = [[NSString alloc] init];
//    //UIWebView *myUIWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10,10,MAXTEXTWIDTH ,200)];
//
//    //NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
//     NSString *text=@"";
//    for (unichar ch = 0xE600; ch <= 0xE61B; ch++){
//        text = [text stringByAppendingFormat:@"%C", ch];
//    }
//    //NSLog(text);
//    self.myHTML = [self parseStringToHTML:text];
//    
//    //[myUIWebView loadHTMLString:self.myHTML baseURL:baseURL];
//    //myUIWebView.scrollView.scrollEnabled = NO;
//    //[self.view addSubview:myUIWebView];
//    //NSLog(@"%f",myUIWebView.scrollView.contentSize.height);
//	// Do any additional setup after loading the view.
//    
//    
//    DTAttributedLabel *newLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(10, 200, MAXTEXTWIDTH, 200)];
//    newLabel.numberOfLines = 0;
//    newLabel.lineBreakMode = NSLineBreakByWordWrapping;
//    newLabel.delegate = self;
//    NSDictionary *attributes = @{DTDefaultFontFamily:@"TDTEmoFull",
//                                 DTDefaultFontSize:@15};
//    
////CTFontDescriptorRef searchingFontDescriptor = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attributes);
////    
////   CTFontRef matchingFont = CTFontCreateWithFontDescriptor(searchingFontDescriptor, 15.0f, NULL);
////    
////    UILabel *llabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
////    llabel.text = @"QQQQQPP";
////
//    
////    NSData *abc = [self.myHTML dataUsingEncoding:NSUTF8StringEncoding];
////    NSDictionary *builderOptions = @{
////                                     DTDefaultFontFamily: @"TDTVera",
////                                     DTDefaultFontSize:@12,
////                                     };
////    NSString *fontName = (__bridge NSString *)CTFontCopyName(matchingFont, kCTFontPostScriptNameKey);
////    NSLog(fontName);
////    
////    DTCoreTextFontDescriptor *descriptor = [[DTCoreTextFontDescriptor alloc] init];
////    
////    descriptor.fontFamily = @"TDTVera";
////    descriptor.boldTrait    = NO ;
////    descriptor.italicTrait  = NO;
////    descriptor.pointSize    = 15.0f;
////    
////    CTFontRef ctFont = [descriptor newMatchingFont];
////    
////    [UIFont fontWithCTFont:ctFont];
////    CGFloat pointSize = CTFontGetSize(ctFont);
////    
////    NSString *fontPostScriptName = (__bridge NSString *)CTFontCopyPostScriptName(ctFont);
////    
////    UIFont *fontFromCTFont = [UIFont fontWithName:fontPostScriptName size:pointSize];
////    
////    CFRelease(ctFont);
////    CGFloat fontSize = CTFontGetSize(matchingFont);
////    UIFont *font = [UIFont fontWithCTFont:ctFont];
////    llabel.backgroundColor = [UIColor blueColor];
//    DTHTMLAttributedStringBuilder *stringBuilder = [[DTHTMLAttributedStringBuilder alloc] initWithHTML:[[self parseStringToHTML:text] dataUsingEncoding:NSUTF8StringEncoding]
//                                                                                                options:attributes
//                                                                                    documentAttributes:nil];
//   newLabel.attributedString = [stringBuilder generatedAttributedString] ;
//    
////    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 300)];
////    label1.numberOfLines = 0;
////    label1.text = @"uiwbfwjbfkljsdfbkasmnopqrstuvwxyz01234Iam=dughwv56789ABCDEFGHIJKLMNOPQRTSUVWXYZ\0  ";
////    UIFont *ff = [UIFont fontWithName:@"TDTEmofull" size:15.0f];
////    label1.font = ff;
////    NSLog(@"%f %f %f %f %f",ff.pointSize, ff.ascender, ff.descender, ff.capHeight, ff.xHeight);
//////    label1.attributedText = [[NSAttributedString alloc] initWithString:@"abcdefghijhelloklmnopqrstuvwxyz01234Iam=dughwv56789ABCDEFGHIJKLMNOPQRTSUVWXYZ"
////                                                            attributes:@{NSFontAttributeName:[UIFont fontWithName:@"TDTVera" size:60.0f]}];
////                             
//   // [self.view addSubview:label1];
//    
////    UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 100)];
////    label11.numberOfLines = 0;
////   // label11.attributedText = [[NSAttributedString alloc] initWithString:@"abcdefghijhelloklmnopqrstuvwxyz01234Iam=dughwv56789ABCDEFGHIJKLMNOPQRTSUVWXYZ"
//     //                                                       attributes:@{NSFontAttributeName:[UIFont fontWithName:@"TDTEmofull" size:15.0f]}];
//    //label11.backgroundColor = [UIColor blueColor];
//    //[self.view addSubview:label11];
//
//    
////    llabel.font = fontFromCTFont;
////    NSLog(@"%@ %@",font,ctFont);
////    //NSLog(@"Object Size: %d",abc.length);
//  //  NSLog(@"%@",[UIFont fontWithName:@"TDTVera" size:17.0f]);
//    //[self.view addSubview:llabel];
//    //[self.view addSubview:label];
//    //[self.view addSubview:newLabel];
//    
//    
//    [self.view addSubview:newLabel];
//    
//    
////}
//- (NSAttributedString *)createCustomAttributedStringFromString:(NSString *)string {
//    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"TDTCustomFontSmall" size:15.0f],};
//    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
//    NSScanner *scanner = [NSScanner scannerWithString:string];
//    while (![scanner isAtEnd]) {
//        [scanner scanUpToCharactersFromSet:self.emoticonSet intoString:NULL]; // skip non-uppercase characters
//        NSString *temp;
//        NSUInteger location = [scanner scanLocation];
//        if ([scanner scanCharactersFromSet:self.emoticonSet intoString:&temp]) {
//            NSRange range = NSMakeRange(location, [temp length]);
//            NSLog(@"%@",[NSValue valueWithRange:range]);
//            [attrStr setAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"TDTCustomFontSmall" size:15.0f],} range:range];
//        }
//    }

//    NSInteger len = string.length,i = 0;
//    while (i < len) {
//        NSRange tempRange = [string rangeOfCharacterFromSet:self.emoticonSet];
//        NSLog(@"%@",[NSValue valueWithRange:tempRange]);
//        if (tempRange.location == NSNotFound)
//        break;
//    }
//    return [attrStr copy];
//}

- (void)viewDidLoad {
//    NSString *emoticonString = @"";
//    for (unichar ch = 0xE01E0; ch <= 0xE61B; ch++) {
//        emoticonString = [emoticonString stringByAppendingFormat:@"%C", ch];
//    }
   // self.emoticonSet = [NSCharacterSet characterSetWithCharactersInString:emoticonString];
    NSString *text=@"Hello, how are you? Have fun with all these emoticons.\U00100002 \U00100000 \U00100001";
  //  emoticonString = [emoticonString stringByAppendingString:@" Hello, I am back!! http://www.google.com"];
    
  //  NSLog(@"%@",[UIFont fontNamesForFamilyName:@"TDT Custom Font"]);
    
    DTAttributedLabel *labelDT = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(10, 30, 250, 350)];
    labelDT.attributedString = [[NSAttributedString alloc] initWithString:text
                                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:@"TDTCustomFont" size:15.0f],}];
    [self.view addSubview:labelDT];
    
    OHAttributedLabel *labelOH = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(10, 200, 250, 350)];
    labelOH.attributedText = labelDT.attributedString;
    [self.view addSubview:labelOH];
    
//    NSLog(@"%D",emoticonString.length);
//    NSLog(@"%@",emoticonString);
   // NSLog(@"%@",[self createCustomAttributedStringFromString:emoticonString]);
}

-(NSString *) parseStringToHTML: (NSString *)text
{
    __block NSString *text1 = [NSString stringWithFormat:@"<html><p>%@</p></html>",text];
//    [self.emoticonDict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
//        text1 = [text1 stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"<img height=15 width= 15 src=\"%@\">",obj]];
//    }];
    return text1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
