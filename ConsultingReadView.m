//
//  ConsultingReadView.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 23..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "ConsultingReadView.h"
#import "AppDelegate.h"

@interface ConsultingReadView (){
    BOOL is_iPhone_5;
    NSDictionary *dic;
}
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UILabel *date_lbl;
@property (weak, nonatomic) IBOutlet UILabel *place_lbl;
@property (weak, nonatomic) IBOutlet UILabel *motive_lbl;
@property (weak, nonatomic) IBOutlet UILabel *method_lbl;
@property (weak, nonatomic) IBOutlet UILabel *category_lbl;
@property (weak, nonatomic) IBOutlet UITextView *story_txt;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;

- (IBAction)back:(UIButton *)sender;
- (IBAction)mody:(UIButton *)sender;
@end

@implementation ConsultingReadView
@synthesize dic_dic;

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
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    dic = dic_dic;
//    dic = delegate.consulting_data;
    
    self.date_lbl.text = [dic objectForKey:@"date"];
    self.place_lbl.text = [dic objectForKey:@"location"];
    self.motive_lbl.text = [dic objectForKey:@"motive"];
    self.method_lbl.text = [dic objectForKey:@"category"];
    self.story_txt.text = [dic objectForKey:@"story"];
    

    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        //            self.view.center = CGPointMake(160, 240);
        
        if (is_iPhone_5) {
            
            [self.scroll_view setContentSize:CGSizeMake(320, 650)];
            
        }else{
            self.scroll_view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+80);
            [self.scroll_view setContentSize:CGSizeMake(320, 568)];
            //                [self.scroll_view setFrame:CGRectMake(0, 20, 320, 480)];
        }
        
    }else{
        
        [self.scroll_view setContentSize:CGSizeMake(758, 1024)];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mody:(UIButton *)sender {
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
