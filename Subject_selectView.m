//
//  Subject_selectView.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 16..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Subject_selectView.h"
#import "Subject_Data.h"

@interface Subject_selectView (){
    NSMutableArray *array;
    
    NSMutableArray *array2;
    
    NSMutableArray *array3;
    
    NSArray *s_arr;
    
    int subject;
    
    int evo;
    
    int subject_num;
    
    NSMutableArray *remain_subject;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pick_view;

- (IBAction)done:(UIButton *)sender;

- (IBAction)down:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *subject_lbl;
@property (weak, nonatomic) IBOutlet UILabel *evo_lbl;

@end

@implementation Subject_selectView

- (void)viewDidLoad {
    [super viewDidLoad];
    


    self.pick_view.dataSource = self;
    self.pick_view.delegate = self;
    
    array = [NSMutableArray arrayWithObjects:@"국어", @"도덕", @"사회", @"수학", @"과학", @"실과", @"체육", @"음악", @"미술", @"영어", nil];
    array3 = [[NSMutableArray alloc]init];
    
    [array3 removeAllObjects];
    
    array3 = array;
    
    Subject_Data *s_data = [[Subject_Data alloc]init];
    
    remain_subject = [[NSMutableArray alloc]init];
    [remain_subject removeAllObjects];
    
    s_arr = [s_data getSubjectName];
    
    subject_num = (int)[s_arr count];
    
//    NSLog(@" s_arr = %d, array=%d, array3 = %d", [s_arr count], [array count], [array3 count]);
    
    if ([s_arr count] == 0) {
//        s_arr = array;
    }else if([s_arr count] == 10){
        [array3 removeAllObjects];
    }else{
        for (int i=0; i<[s_arr count]; i++) {
            //            NSLog(@"s_arr = %@",[[s_arr objectAtIndex:i] objectForKey:@"subject.Name"]);
            //            NSLog(@"array = %@", [array objectAtIndex:i]);
            for (int j = 0; j<[array count]; j++) {
                if ([[[s_arr objectAtIndex:i] objectForKey:@"subject.Name"] isEqualToString:[array objectAtIndex:j]]) {
                    
                    
                    //                    NSLog(@"j = %d",j);
                    //                    NSLog(@"i = %d",i);
                    
                    [array3 removeObjectAtIndex:j];
//                    
//                    NSLog(@"arr3 = %@",[array3 objectAtIndex:0]);
//                    
//                    NSLog(@"array count = %lu", (unsigned long)[array count]);
                    
                }else{
                    
                    
                }
            }
        }
    }
    
    if ([s_arr count] == 0) {
        self.subject_lbl.text = [array objectAtIndex:0];
    }
    if ([s_arr count]<10 && [s_arr count] > 0) {
        self.subject_lbl.text = [array3 objectAtIndex:0];
    }
    
    
    
    array2 = [NSMutableArray arrayWithObjects:@"1영역 평가",@"2영역 평가",@"3영역 평가",@"4영역 평가",@"5영역 평가",@"6영역 평가", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    if ([array3 count]>0 && [array3 count]<11) {
        
        
        
        
        Subject_Data *s_data = [[Subject_Data alloc]init];
        
        NSArray *m_arr = [s_data getSubjectName];
        
        subject_num = (int)[m_arr count];
        
        [s_data addSubjectWithIDno:subject_num Subject_Name:self.subject_lbl.text];
        
        
        
//        NSMutableArray *arr = [[NSMutableArray alloc]init];
//        
//        [arr removeAllObjects];
        
//       NSArray *arr = [s_data getSubjectName];
        
//        NSLog(@"arr_cnt = %d", [arr count]);
        
//         NSDictionary *dic = [arr objectAtIndex:0];
//        
//        NSLog(@"dic.union = %@",[dic objectForKey:@"subject.name"]);
        
//        NSMutableString *str = [[NSMutableString alloc]init];
        
        [array removeObjectAtIndex:subject];
        if (subject_num < 9) {
            self.subject_lbl.text = [array3 objectAtIndex:0];
        }
        
        self.evo_lbl.text = @"평가 개수";
        
        if ([array3 count] == 0) {
            [array2 removeAllObjects];
        }
        
        
        [self.pick_view reloadAllComponents];
        
        
    }
}

- (IBAction)down:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0) {
        return [array3 count];
    }else{
        return [array2 count];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return [array3 objectAtIndex:row];
    }else{
        return [array2 objectAtIndex:row];
    }
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        for (int i= 0; i < [array3 count]; i++) {
            if (row  == i) {
                self.subject_lbl.text = [array3 objectAtIndex:row];
                
                subject = i;
            }
        }
        
    }else{
        
        for (int i= 0; i < [array2 count]; i++) {
            if (row  == i) {
                self.evo_lbl.text = [array2 objectAtIndex:row];
                
                evo = i;
            }
        }
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
