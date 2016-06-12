//
//  SettingView.m
//  Students_Management
//
//  Created by kimsung jun on 2014. 6. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "SettingView.h"
#import "DataBase_AllRemove.h"
@interface SettingView (){
    
    UIView *modal_View;
    UITextField *secu_TxtF;
    UIViewController *mView;
    
    BOOL is_iPhone_5;
    
    int is_ok;
}

@property (weak, nonatomic) IBOutlet UITextField *txt_1;
@property (weak, nonatomic) IBOutlet UIButton *confirm_btn;

@property (weak, nonatomic) IBOutlet UITextField *txt_2;
- (IBAction)password_Save:(UIButton *)sender;
- (IBAction)delete_database:(UIButton *)sender;

@end

@implementation SettingView

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
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
    if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
        is_iPhone_5 = YES;
    }else{
        is_iPhone_5 = NO;
    }
    
    mView = [[UIViewController alloc]init];
    
    
    UIImageView *bg_img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"security_bg"]];
    
    if (is_iPhone_5 == YES) {
        mView.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 568)];
        bg_img.frame = CGRectMake(0, 0, 320, 568);
    }else{
        mView.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 480)];
        bg_img.frame = CGRectMake(0, 0, 320, 480);
    }
    
    
    
    
    
    [mView.view addSubview:bg_img];
    
    secu_TxtF = [[UITextField alloc]initWithFrame:CGRectMake(37, 148, 246, 30)];
    [secu_TxtF setBackgroundColor:[UIColor whiteColor]];
    
    [mView.view addSubview:secu_TxtF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"security_btn2.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(122, 186, 76, 72);
    [btn addTarget:self action:@selector(btn_Down) forControlEvents:UIControlEventTouchUpInside];
    //    [btn addTarget:self action:@selector(btn_End) forControlEvents:UIControlEventEditingDidEnd];
    [mView.view addSubview:btn];
        
        [secu_TxtF becomeFirstResponder];
        
        secu_TxtF.secureTextEntry = YES;
    
    [self presentViewController:mView animated:YES completion:nil];
        
    }else{
        
        mView = [[UIViewController alloc]init];
        
        UIImageView *bg_img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"security_bg"]];
        
        mView.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 568)];
        bg_img.frame = CGRectMake(0, 0, 768, 1024);
        
        [mView.view addSubview:bg_img];
        
        secu_TxtF = [[UITextField alloc]initWithFrame:CGRectMake(57, 301, 649, 30)];
        [secu_TxtF setBackgroundColor:[UIColor whiteColor]];
        
        [mView.view addSubview:secu_TxtF];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"security_btn2.png"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(315, 357, 132, 132);
        [btn addTarget:self action:@selector(btn_Down) forControlEvents:UIControlEventTouchUpInside];
        //    [btn addTarget:self action:@selector(btn_End) forControlEvents:UIControlEventEditingDidEnd];
        [mView.view addSubview:btn];
        
        [secu_TxtF becomeFirstResponder];
        
        secu_TxtF.secureTextEntry = YES;
        
        [self presentViewController:mView animated:YES completion:nil];
        
    }

    self.txt_1.delegate = self;
    self.txt_2.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    
    
    self.confirm_btn.hidden = YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //    if (_txt_f.text.length<2) {
    //        _conform_Btn.hidden = YES;
    //    }else{
    //
    //        _conform_Btn.hidden = NO;
    //    }
    
    return YES;
}

//텍스트 필드 글자수 제한 걸기
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (self.txt_1.text.length >=3) {
        self.confirm_btn.hidden = NO;
        return YES;
    }else{
        
        self.confirm_btn.hidden = YES;
        return YES;
    }
}



-(void) btn_End{
    [secu_TxtF resignFirstResponder];
}

-(void)btn_Down{
    
    [self sound_btn2:@"pik"];
    
    NSString *str = secu_TxtF.text;
    
     NSUserDefaults *security = [NSUserDefaults standardUserDefaults];
    
    if ([str isEqualToString:[security objectForKey:@"secure"]]) {
        
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"pkpk"];
        
//        [self presentViewController:nv animated:TRUE completion:nil];
        [mView dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        
//        //        [_secure_text resignFirstResponder];
//        //        _txt_f.text = nil;
//        //        [_txt_f becomeFirstResponder];
//        
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.txt_1 resignFirstResponder];
    [self.txt_2 resignFirstResponder];
}

- (IBAction)password_Save:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    if ([self.txt_1.text isEqualToString:self.txt_2.text]) {
        NSUserDefaults *security = [NSUserDefaults standardUserDefaults];
        
        NSString *str = self.txt_1.text;
        
        [security setObject:str forKey:@"secure"];
        
        [security synchronize];
        
        is_ok = 2;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"변경 완료"
                                                        message:@"비밀번호가 변경되었습니다."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        [self.txt_2 resignFirstResponder];
    }else{
        self.txt_1.text = nil;
        self.txt_2.text = nil;
        
        [self.txt_1 becomeFirstResponder];
    }
    
    self.txt_1.text = nil;
    self.txt_2.text = nil;
}

- (IBAction)delete_database:(UIButton *)sender {

    is_ok = 1;
    
    [self sound_btn:@"click1"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"데이터 삭제"
                                                    message:@"한 번 삭제된 데이터는 복구를 할 수 없습니다.\n 그래도 삭제 하시겠습니까?"
                                                   delegate:self
                                          cancelButtonTitle:@"아니오"
                                          otherButtonTitles:@"네", nil];
    [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (is_ok == 1) {
        
        if (buttonIndex == 1) {
            DataBase_AllRemove *del_data = [[DataBase_AllRemove alloc]init];
            
            [del_data data_all_remove];
            
            is_ok = 2;
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"삭제 완료"
                                                            message:@"모든 데이터가 삭제 되었습니다."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }else{
        
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
