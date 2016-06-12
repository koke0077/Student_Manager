//
//  LifeView.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 13..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "LifeView.h"
#import "Point_data.h"
#import "RedPointView.h"
#import "Student_Data.h"
#import "AppDelegate.h"
#import "BluePoint.h"

@interface LifeView (){
    
    NSMutableArray *myArray;
    
    NSMutableArray *myArray2;
    
    
    NSDictionary *dic;
    
    int num;
    
    UILabel *view_name;
}


@end

@implementation LifeView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    Student_Data *st_data = [[Student_Data alloc]init];
    
    myArray = [[NSMutableArray alloc]init];
    
    [myArray removeAllObjects];
    
//    [myArray setArray:[st_data getRecords]];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myArray = delegate.face_arr;
    
    myArray2 = [NSMutableArray arrayWithCapacity:0]; //myArray2 초기화
    for (int a = 0; a < myArray.count; a++) {       //myArray2 초기화
        [myArray2 addObject:@"0"];                   //myArray2 초기화
    }
    
    
    
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myArray count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    dic = [delegate.face_arr objectAtIndex:indexPath.row];
    
    UIImage *img = [UIImage imageWithData:[dic objectForKey:@"img_data"]];
    
    Point_data *p_data = [[Point_data alloc]init];
    
    NSArray *member = [p_data getPointDataStudent_idno:(int)indexPath.row];
    
    UIImageView *face_img;
    UILabel *name_label;
    UILabel *red_label;
    UILabel *sum_label;
    UILabel *blue_label;
    UITextView *txtView;
//    UIButton *red_btn;
//    UIButton *blue_btn;
    
    
    face_img = (UIImageView *)[cell viewWithTag:111];
    name_label = (UILabel *)[cell viewWithTag:222];
    red_label = (UILabel *)[cell viewWithTag:333];
    blue_label = (UILabel *)[cell viewWithTag:555];
    sum_label = (UILabel *)[cell viewWithTag:444];
    txtView = (UITextView *)[cell viewWithTag:6];
//    red_btn = (UIButton *)[cell viewWithTag:7];
//    blue_btn = (UIButton *)[cell viewWithTag:8];
    
    face_img.image = img;
    name_label.text = [[myArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    red_label.text = @"0";
    blue_label.text = @"0";
    sum_label.text = @"0";
    txtView.text = nil;
    

//    NSLog(@"index = %ld",(long)indexPath.row);
    
    if ([member count] != 0) {
        red_label.text = [[member objectAtIndex:0] objectForKey:@"redpoint"];
        blue_label.text = [[member objectAtIndex:0] objectForKey:@"bluepoint"];
        sum_label.text = [[member objectAtIndex:0] objectForKey:@"sumpoint"];
        txtView.text = [[member objectAtIndex:0] objectForKey:@"reason"];
    }
    
    UIButton *red_btn = [[UIButton alloc]init];
    UIButton *blue_btn = [[UIButton alloc]init];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        red_btn.frame = CGRectMake(31, 49, 65, 65);
        blue_btn.frame = CGRectMake(224, 49, 65, 65);
        
    }else{
        
        red_btn.frame = CGRectMake(75, 165, 120, 120);
        blue_btn.frame = CGRectMake(533, 165, 120, 120);
    }
    
    [cell addSubview:red_btn];
    
    [red_btn addTarget:self action:@selector(red_action:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:blue_btn];
    
    [blue_btn addTarget:self action:@selector(blue_action:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)red_action:(id)sender{
    
    [self sound_btn2:@"pik"];
    
    UIButton *senderButton = (UIButton *)sender;
    UITableViewCell *buttonCell = (UITableViewCell *)senderButton.superview;
//    UITableView* table = (UITableView *)[buttonCell superview];
    NSIndexPath* pathOfTheCell = [self.tableview indexPathForCell:buttonCell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.students_idno = (int)rowOfTheCell;
//    NSLog(@"rowofthecell %d", (int)rowOfTheCell);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"red_point"];
        
        [self presentViewController:nv animated:YES completion:nil];
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:[NSBundle mainBundle]];
        UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"red_point"];
        
        [self presentViewController:nv animated:YES completion:nil];
        
    }
    
}

-(void)blue_action:(id)sender{
    
    [self sound_btn2:@"pik"];
    
    UIButton *senderButton = (UIButton *)sender;
    UITableViewCell *buttonCell = (UITableViewCell *)senderButton.superview;
    //    UITableView* table = (UITableView *)[buttonCell superview];
    NSIndexPath* pathOfTheCell = [self.tableview indexPathForCell:buttonCell];
    NSInteger rowOfTheCell = [pathOfTheCell row];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.students_idno = (int)rowOfTheCell;
//    NSLog(@"rowofthecell %d", (int)rowOfTheCell);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
        UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"blue_point"];
        
        [self presentViewController:nv animated:YES completion:nil];
        
    }else{
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:[NSBundle mainBundle]];
        UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"blue_point"];
        
        [self presentViewController:nv animated:YES completion:nil];
        
    }
    
}

-(void) sound_btn:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}
-(void) sound_btn2:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}

@end
