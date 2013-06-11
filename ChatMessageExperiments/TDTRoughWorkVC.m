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

@interface TDTRoughWorkVC ()
@property (nonatomic, strong) NSMutableDictionary * emoticonDict;
@property (nonatomic, strong) NSString *myHTML;
@end

@implementation TDTRoughWorkVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.emoticonDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"happyEmoticon.png",    @":)",
                                   @"sadEmoticon.png",      @":(",
                                   @"testImg",              @"[]",
        nil];
        self.myHTML = [[NSString alloc] init];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.emoticonDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"happyEmoticon.png",    @":)",
                         @"sadEmoticon.png",            @":(",
                         @"testImg.png",                @"[]",
                         nil];
    self.myHTML = [[NSString alloc] init];
    UIWebView *myUIWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10,10,MAXTEXTWIDTH ,200)];

    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    

    self.myHTML = [self parseStringToHTML:@"Hello, how are you? :) I am Good [] :(:)"];
    
    [myUIWebView loadHTMLString:self.myHTML baseURL:baseURL];
    //myUIWebView.scrollView.scrollEnabled = NO;
    [self.view addSubview:myUIWebView];
    //NSLog(@"%f",myUIWebView.scrollView.contentSize.height);
	// Do any additional setup after loading the view.
    
    
    DTAttributedLabel *newLabel = [[DTAttributedLabel alloc] initWithFrame:CGRectMake(10, 200, MAXTEXTWIDTH, 200)];
    newLabel.numberOfLines = 0;
    newLabel.lineBreakMode = NSLineBreakByWordWrapping;
    newLabel.delegate = self;
    NSData *abc = [self.myHTML dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *builderOptions = @{
                                     DTDefaultFontFamily: @"Helvetica",
                                     DTDefaultFontSize:@15,
                                     
                                     };
    DTHTMLAttributedStringBuilder *stringBuilder = [[DTHTMLAttributedStringBuilder alloc] initWithHTML:abc
                                                                                               options:builderOptions
                                                                                    documentAttributes:nil];
    
    
    newLabel.attributedString = [stringBuilder generatedAttributedString] ;
    NSLog(@"Object Size: %d",abc.length);
    [self.view addSubview:newLabel];
}

-(NSString *) parseStringToHTML: (NSString *)text
{
    __block NSString *text1 = [NSString stringWithFormat:@"<html><p>%@</p></html>",text];
    [self.emoticonDict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        text1 = [text1 stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"<img height=15 width= 15 src=\"%@\">",obj]];
    }];
    return text1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
