//
//  InfomationView.m
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "InfomationView.h"
#import "AppDelegate.h"
#import "DetailView.h"
#import "Show_View.h"
#import <sqlite3.h>
#import "Student_Data.h"

@interface InfomationView (){
    
    NSMutableArray *myArray;
    
    Student_Data *st_data;
}
- (IBAction)add_btn:(UIButton *)sender;

@end

@implementation InfomationView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    st_data = [[Student_Data alloc]init];
    
     [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    myArray = [NSMutableArray array];
    
    [myArray removeAllObjects];
    
    
    
    [myArray setArray:[st_data getRecords]];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    delegate.face_arr = myArray;
    
//    id appId = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    [myArray setArray:[appId getRecords]];
    
    //    NSLog(@"count = %d",[myArray count]);
    [_tableview reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     return [myArray count];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
//		id AppID = [[UIApplication sharedApplication] delegate];
        
//		[AppID removeDataWithNo:[[[myArray objectAtIndex:indexPath.row] objectForKey:@"no"] intValue]];
        
//        NSLog(@"%ld",(long)indexPath.row);
        
        NSDictionary *dic = myArray[indexPath.row];
        
        int remove_num = [[dic objectForKey:@"no"] intValue];
        
//        NSLog(@"%@",[dic objectForKey:@"name"]);
//        
//        NSLog(@" remove num = %d", remove_num);
        
        [st_data removeDataWithStudents_Idno:remove_num indexPath:(int)indexPath.row];
        
		[myArray removeObjectAtIndex:indexPath.row];
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        delegate.face_arr = myArray;
        
//        NSLog(@"NSArray = %@", indexPath);
        
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *label;
    
    
    
    label = (UILabel *)[cell viewWithTag:2];
    
    label.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    
//    NSLog(@"name = %@",[[myArray objectAtIndex:indexPath.row]objectForKey:@"name"]);
    
    UIImageView *image_view;
    
    image_view = (UIImageView *)[cell viewWithTag:1];
    
    NSDictionary *dic = myArray[indexPath.row];
    
    image_view.image = [UIImage imageWithData:[dic objectForKey:@"img_data"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"번호 ? = %d",(int)[[myArray objectAtIndex:indexPath.row] objectForKey:@"no"]);
    
    [self sound_btn:@"click1"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"add"]){
        
    }else if([[segue identifier] isEqualToString:@"data"]){
        //세그웨이에서 테이블뷰 선택된 셀의 번호 가져오기
        NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
//        NSLog(@"%ld",(long)indexPath.row);
        NSDictionary *dic = myArray[indexPath.row];
        [[segue destinationViewController] setDic:dic];
//        [[segue destinationViewController] setMyArray:myArray];
        [[segue destinationViewController] setRow_num:indexPath.row];
        
        
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        delegate.student_row = (int)indexPath.row;
    }
    
    
    
    //    NSLog(@"click");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_delete:(UIButton *)sender {
    [self sound_btn:@"click1"];
    [_tableview setEditing:!_tableview.editing animated:YES];
    
}

- (IBAction)btn:(id)sender {
    [self sound_btn:@"click1"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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


- (IBAction)add_btn:(UIButton *)sender {
    [self sound_btn:@"click1"];
}
@end
