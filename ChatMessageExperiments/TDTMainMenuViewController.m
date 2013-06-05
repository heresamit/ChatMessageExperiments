//
//  TDTMainMenuViewController.m
//  ChatMessageExperiments
//
//  Created by Amit Chowdhary on 04/06/13.
//  Copyright (c) 2013 Amit Chowdhary. All rights reserved.
//

#import "TDTMainMenuViewController.h"
#import "TDTBubbleImplementationsMenuViewController.h"

@interface TDTMainMenuViewController ()
@property (nonatomic,strong) NSMutableArray *messageArray;
@end

@implementation TDTMainMenuViewController

-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageFile" ofType:@"plist"];
        self.messageArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"ChatBubblesImplementationSegue"])
    {
        TDTBubbleImplementationsMenuViewController *dvc = (TDTBubbleImplementationsMenuViewController *)[segue destinationViewController];
        dvc.messageArray = self.messageArray;
        [dvc parseData];
       //parse Some data there?
    }
}
@end