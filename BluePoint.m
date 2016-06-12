//
//  BluePoint.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 14..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "BluePoint.h"
#import "Point_data.h"
#import "AppDelegate.h"

@interface BluePoint (){
    
    AppDelegate *delegate;
    
    NSMutableString *txt_str;
    
}
- (IBAction)save:(UIButton *)sender;
- (IBAction)cancel:(UIButton *)sender;
- (IBAction)btn1:(UIButton *)sender;
- (IBAction)btn2:(UIButton *)sender;
- (IBAction)btn3:(UIButton *)sender;
- (IBAction)btn4:(UIButton *)sender;
- (IBAction)btn5:(UIButton *)sender;
- (IBAction)btn6:(UIButton *)sender;
- (IBAction)btn7:(UIButton *)sender;
- (IBAction)btn8:(UIButton *)sender;
- (IBAction)btn9:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtF;

@end

@implementation BluePoint

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)save:(UIButton *)sender {
    
    if (self.txtF != nil) {
        Point_data *p_data = [[Point_data alloc]init];
        
        NSDateFormatter *today = [[NSDateFormatter alloc]init];
        [today setDateFormat:@"yyyy-MM-dd-hh"];
        //        NSMutableString *date = [[NSMutableString alloc]initWithString:[today stringFromDate:[NSDate date]]];
        
        txt_str = [NSMutableString stringWithString:[today stringFromDate:[NSDate date]]];
        
        
        
        [txt_str appendFormat:@" %@",self.txtF.text];
        
//        NSLog(@"txtF = %@", self.txtF.text);
        
        NSArray *data_array = [p_data getPointDataStudent_idno:delegate.students_idno];
        
//        NSLog(@"data_array count = %d", (int)[data_array count]);
        if ((int)[data_array count] ==0) {
            
            [txt_str appendString:@"\n"];
            
            int red_point = 0;
            int sum_point = 0;
            int blue_point = 1;
            
            
            sum_point++;
            
            [p_data addDataIdnoStudent_idno:delegate.students_idno
                                  BluePoint:[NSString stringWithFormat:@"%d",blue_point]
                                   RedPoint:[NSString stringWithFormat:@"%d",red_point]
                                   SumPoint:[NSString stringWithFormat:@"%d",sum_point]
                                     Reason:txt_str];
            
            
            //            NSLog(@"%@",[NSString stringWithFormat:@"%d",sum_point]);
            
            
        }else{
            
//            NSLog(@"student_idno = %d", delegate.students_idno);
            
            NSDictionary *data_dic = [data_array objectAtIndex:0];
            
            [txt_str appendString:@"\n"];
            
            int red_point = [[data_dic objectForKey:@"redpoint"] intValue];
            int sum_point = [[data_dic objectForKey:@"sumpoint"] intValue];
            int blue_point = [[data_dic objectForKey:@"bluepoint"] intValue];
            NSMutableString *db_str= [[NSMutableString alloc]initWithString:[data_dic objectForKey:@"reason"]];
            [db_str appendString:txt_str];
            
//            NSLog(@"db_str = %@",db_str);
            
//            NSLog(@" red_point = %d", red_point);
//            NSLog(@"sum_point = %d", sum_point);
//            NSLog(@"blue_pint = %d", blue_point);
//            
            blue_point++;
            sum_point++;
            //            NSLog(@"sum ======= %d",sum_point);
            
            [p_data updateDataStudent_idno:delegate.students_idno
                                 BluePoint:[NSString stringWithFormat:@"%d",(int)blue_point]
                                  RedPoint:[NSString stringWithFormat:@"%d",(int)red_point]
                                  SumPoint:[NSString stringWithFormat:@"%d",(int)sum_point]
                                    Reason:db_str];
            
            //             NSLog(@"sumpoint ===== %@",[NSString stringWithFormat:@"%d\nd\ndd",sum_point]);
        }
        
        
    }
    
    
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(UIButton *)sender {
    [self sound_btn:@"click2"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btn1:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(정직)";
}

- (IBAction)btn2:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(책임)";
}

- (IBAction)btn3:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(존중)";
}

- (IBAction)btn4:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(배려)";
}

- (IBAction)btn5:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(공감)";
}

- (IBAction)btn6:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(소통)";
}

- (IBAction)btn7:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(협동)";
}

- (IBAction)btn8:(UIButton *)sender {
    [self sound_btn:@"click1"];
    self.txtF.text = @"(시간관리)";
}

- (IBAction)btn9:(UIButton *)sender {
    [self sound_btn:@"click1"];
    [self.txtF becomeFirstResponder];
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
