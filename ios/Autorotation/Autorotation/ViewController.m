//
//  ViewController.m
//  Autorotation
//
//  Created by 村上 幸雄 on 12/01/23.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL    result = YES;
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
        result = YES;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
        result = YES;
    else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight)
        result = YES;
    else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        result = NO;
    return result;
}

@end
