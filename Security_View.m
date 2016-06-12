//
//  Security_View.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Security_View.h"
#import "AppDelegate.h"

@interface Security_View (){
    
    AppDelegate *delegate;
    NSString *str;
    NSUserDefaults *security;

}

@end

@implementation Security_View

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

    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    _txt_f.text = nil;
    
    [_txt_f becomeFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_txt_f resignFirstResponder];
    
    str = _txt_f.text;
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self resignFirstResponder];
    
    str = _txt_f.text;
    
    
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)no_btn:(UIButton *)sender {
    
    _txt_f.text = nil;
    
    
}

//코드로 스토리보드 전환하기
- (IBAction)yes_btn:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    str = _txt_f.text;
    
    security = [NSUserDefaults standardUserDefaults];
    
    if ([str isEqualToString:[security objectForKey:@"secure"]]) {
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:[NSBundle mainBundle]];
            UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"pkpk"];
            
            [self presentViewController:nv animated:TRUE completion:nil];
            
        }else{
            
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:[NSBundle mainBundle]];
            UIViewController *nv = [storyBoard instantiateViewControllerWithIdentifier:@"pkpk"];
            
            [self presentViewController:nv animated:TRUE completion:nil];
        }
        
        
        
    }else{
        
        //        [_secure_text resignFirstResponder];
        //        _txt_f.text = nil;
        //        [_txt_f becomeFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
//    NSLog(@"ggggg");
    
    
}

-(void) sound_btn:(NSString *) sound_name{
    
    NSString *str2 = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str2 ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}
-(void) sound_btn2:(NSString *) sound_name{
    
    NSString *str2 = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str2 ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}


@end
