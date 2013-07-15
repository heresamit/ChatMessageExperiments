//
//  TDTWebViewData.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 10/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTWebViewData.h"


@implementation TDTWebViewData

-(NSData *) parseStringToHTML: (NSString *)text
{
    __block NSString *text1 = [NSString stringWithFormat:@"<html><p>%@</p></html>",text];
    [self.emoticonDict enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        text1 = [text1 stringByReplacingOccurrencesOfString:key withString:[NSString stringWithFormat:@"<img height= 15 width= 15 src=\"%@\">",obj]];
    }];
    
    return  [text1 dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)initWithText:(NSString *)text withType:(TDTBubbleType)type withEmoticonDict:(NSMutableDictionary *)emoticonDict
{
    self = [super init];
    if(self)
    {
        _isDirty = YES;
        _emoticonDict = emoticonDict;
        _type = type;
        //_temp = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAXTEXTWIDTH, 2)];
        _htmlData = [self parseStringToHTML:text];
//        [_temp loadData:_htmlData MIMEType:@"text/html" textEncodingName:@"utf-8"  baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
//        _temp.delegate = self;
//        _temp.scrollView.scrollEnabled = NO;
//        _temp.opaque = NO;
//        _temp.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{
    CGFloat height = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
    CGFloat width = [[aWebView stringByEvaluatingJavaScriptFromString:@"document.width"] floatValue];
    self.sizeOfWebView = CGSizeMake(width, height);
    self.temp = nil;
}

@end
