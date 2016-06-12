//
//  ConsultingShow.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "ConsultingShow.h"
#import "Consulting_data.h"
#import "AppDelegate.h"

@interface ConsultingShow (){
    BOOL is_Txf;
    BOOL is_iPhone_5;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_1;
@property (weak, nonatomic) IBOutlet UITextField *txt_2;
@property (weak, nonatomic) IBOutlet UITextField *txt_3;
@property (weak, nonatomic) IBOutlet UITextField *txt_4;
@property (weak, nonatomic) IBOutlet UITextField *txt_5;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;

@property (weak, nonatomic) IBOutlet UITextView *txt_View;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;


- (IBAction)save:(UIButton *)sender;
- (IBAction)back:(UIButton *)sender;

@end

@implementation ConsultingShow

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
    
    self.scroll_view.scrollEnabled = YES;
    
    NSArray *fields = @[ self.txt_2, self.txt_3, self.txt_4, self.txt_5, self.txt_View];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
   
    NSDateFormatter *today = [[NSDateFormatter alloc]init];
    [today setDateFormat:@"yyyy년 MM월 dd일 hh시 mm분"];
    
    self.txt_1.text = [NSString stringWithString:[today stringFromDate:[NSDate date]]];
                       
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        //            self.view.center = CGPointMake(160, 240);
        
        if (is_iPhone_5) {
            
            [self.scroll_view setContentSize:CGSizeMake(320, 568)];
            
        }else{
             self.scroll_view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+40);
            [self.scroll_view setContentSize:CGSizeMake(320, 600)];
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



- (IBAction)save:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    Consulting_data *consult_data = [[Consulting_data alloc]init];
//    NSLog(@"consulting_data count = %d",[delegate.consulting_data count]);
    
//    NSLog(@" delegate.consultion_Section = %d", delegate.consultion_Section);
//    NSLog(@"sender.tag = %d",sender.tag);
//    NSLog(@"consult_data getConsultingDataStudent_idno = %d", [[consult_data getConsultingDataStudent_idno:delegate.consultion_Section] count]);
    [consult_data addDataIdno:(int)[[consult_data getConsultingDataStudent_idno:delegate.consultion_Section] count] Student_idno:delegate.consultion_Section Date:self.txt_1.text Location:self.txt_2.text Motive:self.txt_3.text Method:self.txt_4.text Category:self.txt_5.text Story:self.txt_View.text ];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)back:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}


#pragma mark -
#pragma mark Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //    [_scrollView scrollRectToVisible:_txtV.frame animated:YES];
    
    [self.keyboardControls setActiveField:textView];
    
    
    
}



#pragma mark -
#pragma mark Keyboard Controls Delegate



- (void)_addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillAnimate:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    if([notification name] == UIKeyboardWillShowNotification)
    {
        
//        NSLog(@"self.view frame = %f", self.view.frame.size.height);
//        NSLog(@"sef.view origin y = %f", self.view.center.y);
        
//        self.view.center = CGPointMake(160, 0);
        //        [self.view setFrame:CGRectMake(main_View_Frame.origin.x, main_View_Frame.origin.y - keyboardBounds.size.height, main_View_Frame.size.width, main_View_Frame.size.height)];
        //        self.scroll_view.frame = CGRectMake(0, keyboardBounds.size.height, self.scroll_view.frame.size.width, self.scroll_view.frame.size.height);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            if (is_iPhone_5) {
                [self.scroll_view setContentSize:CGSizeMake(320, 800)];
            }else{
                [self.scroll_view setContentSize:CGSizeMake(320, 830)];
                [self.scroll_view setFrame:CGRectMake(0, 0, 320, 480)];
            }
            
        }else{
            
            [self.scroll_view setContentSize:CGSizeMake(768, 1424)];
            
        }
        
        
        
        
        
        
        
        
    }
    else if([notification name] == UIKeyboardWillHideNotification)
    {
        //        [self.view setFrame:CGRectMake(main_View_Frame.origin.x, main_View_Frame.origin.y, main_View_Frame.size.width, main_View_Frame.size.height)];
        //        self.scroll_view.frame = CGRectMake(0, 0, self.scroll_view.frame.size.width, self.scroll_view.frame.size.height);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
//            self.view.center = CGPointMake(160, 240);
            
            if (is_iPhone_5) {
                [self.scroll_view setContentSize:CGSizeMake(320, 830)];
            }else{
                [self.scroll_view setContentSize:CGSizeMake(320, 600)];

                self.scroll_view.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
            }
            
        }else{
            
            [self.scroll_view setContentSize:CGSizeMake(758, 1024)];
            
        }
        
    }
    [UIView commitAnimations];
    
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//
//    [_txtF resignFirstResponder];
//    [_txtV resignFirstResponder];
//    return YES;
//}


- (void)_removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self performSelector:@selector(_addKeyboardNotification)];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    is_Txf = YES;
    
    return YES;
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
