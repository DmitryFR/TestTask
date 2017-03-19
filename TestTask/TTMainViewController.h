//
//  TTMainViewController.h
//  TestTask
//
//  Created by Дмитрий Фролов on 18.03.17.
//  Copyright © 2017 Дмитрий Фролов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VKSdk.h"

@interface TTMainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (strong, nonatomic)VKAccessToken *currentUserToken;
@property (strong, nonatomic)NSMutableArray *videoArray;
@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UISearchBar *searchBar;
@property (strong, nonatomic)NSNumber *offset;
@property (strong, nonatomic)UIActivityIndicatorView *indicator;

@end
