//
//  ViewController.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
    
    AppDelegate *delegate;
}
- (IBAction)btn:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    NSUserDefaults *security = [NSUserDefaults standardUserDefaults];
    
    if ([security stringForKey:@"secure"] == nil) {
        
        delegate.is_Security = NO;
        
    }else{
        
        delegate.is_Security = YES;
    }
    
    if (delegate.is_Security == NO) {
        
        _second_Btn.hidden = YES;
        _first_Btn.hidden = NO;
        
    }else{
        
        _second_Btn.hidden = NO;
        _first_Btn.hidden = YES;
        
    }
    
    BOOL is_iPhone_5;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
     
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
            is_iPhone_5 = YES;
        }else{
            is_iPhone_5 = NO;
        }
        
        if (is_iPhone_5 == YES) {
            
        }else{
            self.first_Btn.frame = CGRectMake(50, 220, 220, 200);
            self.second_Btn.frame = CGRectMake(50, 220, 220, 200);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
}
@end
