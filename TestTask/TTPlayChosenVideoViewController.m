//
//  TTPlayChosenVideoViewController.m
//  TestTask
//
//  Created by Дмитрий Фролов on 19.03.17.
//  Copyright © 2017 Дмитрий Фролов. All rights reserved.
//

#import "TTPlayChosenVideoViewController.h"


@interface TTPlayChosenVideoViewController ()

@end

@implementation TTPlayChosenVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Проигрыватель"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSURL *videoURL = [NSURL URLWithString:[self.video objectForKey:@"player"]];
    UIWebView *playerView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 0.0, 375.0, 667.0)];
    [self.view addSubview: playerView];
    [playerView setBackgroundColor:[UIColor whiteColor]];
    [playerView setScalesPageToFit:YES];
    [playerView loadRequest:[NSURLRequest requestWithURL:videoURL]];
    
    [playerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[playerView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(playerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[playerView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(playerView)]];
}




@end
