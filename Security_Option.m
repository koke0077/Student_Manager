//
//  Security_Option.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Security_Option.h"

@interface Security_Option ()

@end

@implementation Security_Option

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
    _txt_f.delegate = self;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    _conform_Btn.hidden = YES;
    
    [_txt_f becomeFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //    _conform_Btn.hidden = NO;
    
    
    
    
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
    
    if (_txt_f.text.length >=3) {
        _conform_Btn.hidden = NO;
        return YES;
    }else{
        
        _conform_Btn.hidden = YES;
        return YES;
    }
}

- (IBAction)btn:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    if ([self.txt_f.text isEqualToString:self.txt_f2.text]) {
        NSUserDefaults *security = [NSUserDefaults standardUserDefaults];
        
        NSString *str = _txt_f.text;
        
        [security setObject:str forKey:@"secure"];
        
        [security synchronize];
    }else{
        self.txt_f.text = nil;
        self.txt_f2.text = nil;
        
        [self.txt_f becomeFirstResponder];
    }

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
