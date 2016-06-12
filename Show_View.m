//
//  Show_View.m
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Show_View.h"
#import "AppDelegate.h"
#import "Modify_View.h"
#import "Student_Data.h"

@interface Show_View (){
    
    AppDelegate *delegate;
    
    NSMutableArray *myArray;
    
    NSDictionary *my_dic;
    
    UIView *action_view;
    
    int phone_num;
}
- (IBAction)st_call_btn:(UIButton *)sender;
- (IBAction)mom_call_btn:(UIButton *)sender;
- (IBAction)fa_call_btn:(UIButton *)sender;
- (IBAction)house_call_btn:(UIButton *)sender;

@end

@implementation Show_View

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
    
//    action_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    BOOL is_iPhone_5;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
            is_iPhone_5 = YES;
        }else{
            is_iPhone_5 = NO;
        }
        
        if (is_iPhone_5) {
            [_scorll_view setContentSize:CGSizeMake(320, 1150)];
        }else{
            [_scorll_view setContentSize:CGSizeMake(320, 1260)];
            _scorll_view.frame = CGRectMake(0, 70, _scorll_view.frame.size.width, _scorll_view.frame.size.height);
        }

        
    }else{
        
    }
    
    
    //    NSLog(@"%d",_row_num); 
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //키값을 중심으로 데이터 저장. 화면전환시 딕션너리를 모두 넘기는 것이 아니라 no만 넘긴다.
    
//    my_dic = [[NSDictionary alloc]init];
//   [myArray setArray:[delegate getRecordWithNo:(int)[_dic objectForKey:@"no"]]];
    
//    my_dic = [delegate getRecordWithNo:_row_num];
    
    myArray = [NSMutableArray array];
    
    [myArray removeAllObjects];
    
    Student_Data *st_data = [[Student_Data alloc]init];
    
    [myArray setArray:[st_data getRecords]];
    
//    myArray = delegate.face_arr;
//    
//    [myArray setArray:[delegate getRecords]];
    
    _name_label.text = [[myArray objectAtIndex:_row_num]objectForKey:@"name"];
    _birth_label.text = [NSString stringWithFormat:@"%@",
                         [[myArray objectAtIndex:_row_num]objectForKey:@"birth"]];
    
    [_phone1 setTitle:[NSString stringWithFormat:@"%@",
                       [[myArray objectAtIndex:_row_num]objectForKey:@"phone1"]]
             forState:UIControlStateNormal];
    
//    NSRegularExpression
    
    [_phone2 setTitle:[NSString stringWithFormat:@"%@",
                       [[myArray objectAtIndex:_row_num]objectForKey:@"phone2"]]
             forState:UIControlStateNormal];
    
    [_phone3 setTitle:[NSString stringWithFormat:@"%@",
                       [[myArray objectAtIndex:_row_num]objectForKey:@"phone3"]]
             forState:UIControlStateNormal];
    
    [_phone4 setTitle:[NSString stringWithFormat:@"%@",
                       [[myArray objectAtIndex:_row_num]objectForKey:@"tel"]]
             forState:UIControlStateNormal];
    
    _address.text = [NSString stringWithFormat:@"%@",
                     [[myArray objectAtIndex:_row_num]objectForKey:@"address"]];
    
    _memo.text = [NSString stringWithFormat:@"%@",
                  [[myArray objectAtIndex:_row_num]objectForKey:@"memo"]];
    
    _face_img.image = [UIImage imageWithData:[[myArray objectAtIndex:_row_num]objectForKey:@"img_data"]];
    
    
//    NSLog(@"no = %d",(int)[_dic objectForKey:@"no"]);
    
//    NSLog(@"%@",my_dic);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"mody"]){
     
        
        NSDictionary *dic = _dic;
        [[segue destinationViewController] setDic:dic];
        [[segue destinationViewController] setRow_num:_row_num];
        [[segue destinationViewController] setMyArray:myArray];
        
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    
    
    [_memo resignFirstResponder];
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    action_view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-266.0, 320, 50)];
    
    action_view.backgroundColor = [UIColor whiteColor];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [self.view addSubview:action_view];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(130, 10, 60, 30)];
    
    [btn setBackgroundColor:[UIColor greenColor]];
    
    [action_view addSubview:btn];
    
    [UIView commitAnimations];
    
    
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    action_view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    [UIView commitAnimations];
    
    [_memo resignFirstResponder];
    
    [action_view removeFromSuperview];
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
//    NSLog(@"stop");
    
    return YES;
}

- (IBAction)back:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit:(UIButton *)sender {
    [self sound_btn:@"click1"];
}





- (IBAction)st_call_btn:(UIButton *)sender {
    
    phone_num = 1;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"전화를 하시겠습니까?"
                                                    message:[[myArray objectAtIndex:_row_num]objectForKey:@"phone1"]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)mom_call_btn:(UIButton *)sender {
    
    phone_num = 2;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"전화를 하시겠습니까?"
                                                    message:[[myArray objectAtIndex:_row_num]objectForKey:@"phone2"]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)fa_call_btn:(UIButton *)sender {
    
    phone_num = 3;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"전화를 하시겠습니까?"
                                                    message:[[myArray objectAtIndex:_row_num]objectForKey:@"phone3"]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)house_call_btn:(UIButton *)sender {
    
    phone_num = 4;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"전화를 하시겠습니까?"
                                                    message:[[myArray objectAtIndex:_row_num]objectForKey:@"tel"]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*
    if (buttonIndex == 1) {
        NSString *PhoneNum = [NSString stringWithFormat:@"tel:%@",[[myArray objectAtIndex:_row_num]objectForKey:@"phone1"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneNum]];
    }
     */
    if (phone_num == 1) {
        NSString *PhoneNum = [NSString stringWithFormat:@"tel:%@",[[myArray objectAtIndex:_row_num]objectForKey:@"phone1"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneNum]];
    }else if(phone_num == 2){
        NSString *PhoneNum = [NSString stringWithFormat:@"tel:%@",[[myArray objectAtIndex:_row_num]objectForKey:@"phone2"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneNum]];
    }else if(phone_num == 3){
        NSString *PhoneNum = [NSString stringWithFormat:@"tel:%@",[[myArray objectAtIndex:_row_num]objectForKey:@"phone3"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneNum]];
    }else if(phone_num == 4){
        NSString *PhoneNum = [NSString stringWithFormat:@"tel:%@",[[myArray objectAtIndex:_row_num]objectForKey:@"tel"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:PhoneNum]];
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
