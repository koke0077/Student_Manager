//
//  Evolution_Select_View.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Evolution_Select_View.h"
#import "Subject_Data.h"
#import "Evolution_View.h"

@interface Evolution_Select_View (){
    
    NSMutableArray *evoType_arr;
    


    UIView *v1;
}
@property (weak, nonatomic) IBOutlet UIView *add_view;
@property (weak, nonatomic) IBOutlet UITextField *evo_txtF;
- (IBAction)save_btn:(UIButton *)sender;
- (IBAction)cancel_btn:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *Subject_lbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)edit_btn:(UIButton *)sender;
- (IBAction)back_btn:(UIButton *)sender;
- (IBAction)add_evoType:(UIButton *)sender;

@end

@implementation Evolution_Select_View
@synthesize subject_name, subject_dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.Subject_lbl.text = subject_name;
    
    Subject_Data *s_data = [[Subject_Data alloc]init];
    
    evoType_arr = [[NSMutableArray alloc]init];
    
    [evoType_arr removeAllObjects];
    
    
    [evoType_arr setArray:[s_data getSubjectTypeName:subject_name]];

    
    self.add_view.frame = CGRectMake(0, -300, 320, 160);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [evoType_arr count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    UILabel *lbl = (UILabel *)[cell viewWithTag:11];
    
    lbl.text = [[evoType_arr objectAtIndex:indexPath.row] objectForKey:@"typeName"];

    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *subject_name2 = [[evoType_arr objectAtIndex:indexPath.row] objectForKey:@"typeName"];
       
        Subject_Data *s_data = [[Subject_Data alloc]init];
        
        int no = [s_data getSubjectTypeIdnoWithSubjectName:subject_name2];
        
        [s_data deleteSubjectType:subject_name2 Idno:no];
        
        [s_data deleteSubjectIdno:no];
        
        
        NSLog(@"deleteSubjectType = %@, %d", subject_name2, no);

        NSMutableArray *delArray = [[NSMutableArray alloc]init];
        
        [delArray addObject:indexPath];
        
        [evoType_arr removeObjectAtIndex:indexPath.row];
        
//        NSLog(@"NSArray = %@", indexPath);
        
       [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
   
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self sound_btn:@"click1"];
}
- (IBAction)edit_btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (IBAction)back_btn:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)add_evoType:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    [self option_animationDown];
    
    [self.evo_txtF becomeFirstResponder];
}

- (IBAction)save_btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    [self option_animationUp];
    
    Subject_Data *s_data = [[Subject_Data alloc]init];
    
    int no = [[subject_dic objectForKey:@"idno"] intValue];
    
    [s_data addSubjectTypeIdno:(int)(no*10+[evoType_arr count]) Subject_idno:no TypeName:self.evo_txtF.text];
    
    
    NSLog(@"addSubjectTypeIdno %d, %@", (int)(no*10+[evoType_arr count]), self.evo_txtF.text);
    
    [evoType_arr setArray:[s_data getSubjectTypeName:subject_name]];
    
    [self.evo_txtF resignFirstResponder];
    
    [self.tableView reloadData];
}

- (IBAction)cancel_btn:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    [self option_animationUp];
    
    [self.evo_txtF resignFirstResponder];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    Subject_Data *s_data = [[Subject_Data alloc]init];
    
    [evoType_arr setArray:[s_data getSubjectTypeName:subject_name]];
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//    NSLog(@"%ld",(long)indexPath.row);
    
    NSDictionary *dic = [evoType_arr objectAtIndex:indexPath.row];
    
    [[segue destinationViewController] setSubject:subject_name];
    [[segue destinationViewController] setDic:dic];
}

-(void) option_animationUp{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    
    self.add_view.frame = CGRectMake(0, 0, 320, 160);
    
    [UIView commitAnimations];
 
    self.add_view.center = CGPointMake(160, 80);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.add_view.center = CGPointMake(160, -90);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                          }];
                     }];
}

-(void) option_animationDown{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    
    self.add_view.frame = CGRectMake(0, -100, 320, 160);
    
    [UIView commitAnimations];
    
    self.add_view.center = CGPointMake(160, -90);
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.add_view.center = CGPointMake(160, 80);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                          }];
                     }];
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
