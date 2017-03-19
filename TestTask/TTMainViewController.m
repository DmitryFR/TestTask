//
//  TTMainViewController.m
//  TestTask
//
//  Created by Дмитрий Фролов on 18.03.17.
//  Copyright © 2017 Дмитрий Фролов. All rights reserved.
//

#import "TTMainViewController.h"
#import "TTVideoLoader.h"
#import "TTPlayChosenVideoViewController.h"

@implementation TTMainViewController 

-(void)viewDidLoad{
    [self.navigationItem setTitle:@"Поиск видео"];
    self.navigationItem.hidesBackButton = YES;
    
    self.offset = 0;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, 375.0, 667.0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
   self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70, 320, 44)];
    [self.searchBar setDelegate:self];
    [self.searchBar setPlaceholder:@"Введите поисковый запрос"];
    [self.tableView setTableHeaderView:self.searchBar];
    
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
  
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    //romashka
    self.indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    self.indicator.center = self.view.center;
    [self.view addSubview:self.indicator];
    [self.indicator bringSubviewToFront:self.view];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.videoArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.videoArray[indexPath.row] valueForKey:@"title"];
    NSString *path = [self.videoArray[indexPath.row] valueForKey:@"photo_130"];
    cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
    NSNumber *duration = [self.videoArray[indexPath.row]valueForKey:@"duration"];
    NSNumber *min = [NSNumber numberWithLong:duration.integerValue/60];
    NSNumber *sec = [NSNumber numberWithLong:duration.integerValue - min.longValue*60];
    if (sec.longValue>10){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@",min.stringValue,sec.stringValue];
    }
    else {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:0%@",min.stringValue,sec.stringValue];
    }
    
    if(indexPath.row == self.videoArray.count-5){
        TTVideoLoader *loader = [[TTVideoLoader alloc]init];
        self.offset = [NSNumber numberWithLong:self.offset.longValue + 40];
        [loader getVideoArray:self.searchBar.text offset:self.offset response:^(NSMutableArray *responseArray){
            [self.indicator startAnimating];
            self.videoArray = [[self.videoArray arrayByAddingObjectsFromArray:responseArray]mutableCopy];
            [self.tableView reloadData];
            [self.indicator stopAnimating];
        }];

        
    }

    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    TTVideoLoader *loader = [[TTVideoLoader alloc]init];
    self.offset = 0;
    [loader getVideoArray:self.searchBar.text offset:self.offset response:^(NSMutableArray *responseArray){
        [self.indicator startAnimating];
        self.videoArray = responseArray;
        [self.tableView reloadData];
        [self.indicator stopAnimating];
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TTPlayChosenVideoViewController *playVC = [[TTPlayChosenVideoViewController alloc]init];
    playVC.video = self.videoArray[indexPath.row];
    [self.navigationController pushViewController:playVC animated:YES];
}

@end
