//
//  Modify_View.m
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Modify_View.h"
#import "AppDelegate.h"
#import "Student_Data.h"
#define kSocialSecuityNumberPattern @"^\\d{3}[-]\\d{4}[-]\\d{4}$"

@interface Modify_View (){
    
    BOOL home_num;
    
    UIImage *image;
    
    BOOL is_iPhone_5;
    
    AppDelegate *delegate;
    
    
}

@property (nonatomic, strong) BSKeyboardControls *keyboardControls;



@end

@implementation Modify_View

@synthesize myArray;

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
    
    home_num = NO;
    self.phone1.delegate = self;
    self.phone2.delegate = self;
    self.phone3.delegate = self;
    self.phone4.delegate = self;
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    delegate.is_mody = NO;
    
    NSArray *fields = @[ self.phone1, self.phone2, self.phone3, self.phone4, self.name_txt, self.birth_txt, self.address, self.memo];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
    [_scroll_view setScrollEnabled:YES];
    
     image = [UIImage imageWithData:[_dic objectForKey:@"img_data"]];
    
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         
         if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
             is_iPhone_5 = YES;
         }else{
             is_iPhone_5 = NO;
         }
         
         if (is_iPhone_5) {
             [_scroll_view setContentSize:CGSizeMake(320, 1242)];
         }else{
             [_scroll_view setContentSize:CGSizeMake(320, 1153)];
         }
         
     }else{
         
         [self.scroll_view setContentSize:CGSizeMake(768, 954)];
     }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    /*
    
    _face_img.image = image;
    
    _name_txt.text = [_dic objectForKey:@"name"];
    
    _birth_txt.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"birth"]];
    
    _phone1.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone1"]];
    
    _phone2.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone2"]];
    
    _phone3.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone3"]];
    
    _phone4.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"phone4"]];
    
    _address.text = [_dic objectForKey:@"address"];
    
    _memo.text = [_dic objectForKey:@"memo"];
     
     */
    
    _name_txt.text = [[myArray objectAtIndex:_row_num]objectForKey:@"name"];
    _birth_txt.text = [NSString stringWithFormat:@"%@",
                         [[myArray objectAtIndex:_row_num]objectForKey:@"birth"]];
    
    _phone1.text = [NSString stringWithFormat:@"%@",
                    [[myArray objectAtIndex:_row_num]objectForKey:@"phone1"]];
    
    _phone2.text = [NSString stringWithFormat:@"%@",
                    [[myArray objectAtIndex:_row_num]objectForKey:@"phone2"]];
    
    _phone3.text = [NSString stringWithFormat:@"%@",
                    [[myArray objectAtIndex:_row_num]objectForKey:@"phone3"]];
    
    _phone4.text = [NSString stringWithFormat:@"%@",
                    [[myArray objectAtIndex:_row_num]objectForKey:@"tel"]];
    
    
    _address.text = [NSString stringWithFormat:@"%@",
                     [[myArray objectAtIndex:_row_num]objectForKey:@"address"]];
    
    _memo.text = [NSString stringWithFormat:@"%@",
                  [[myArray objectAtIndex:_row_num]objectForKey:@"memo"]];
    
    _face_img.image = image;
    
    [self performSelector:@selector(_addKeyboardNotification)];
    
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

- (IBAction)back:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    NSValue *val =[info objectForKey:UIImagePickerControllerCropRect];
    
    
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    CGRect crop_rect = val.CGRectValue;
    
    //    NSLog(@"%f, %f", crop_rect.size.width, crop_rect.size.height);
    
    //    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], crop_rect);
    
    //    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    CGRect ret = CGRectMake(0, 0, image.size.width, image.size.width);
    
    UIImage *cropped = [self imageByCropping:image toRect:ret];
    
    image = cropped;
    
    _face_img.image = image;
    
}

- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

- (IBAction)save:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    CGSize sacleSize = CGSizeMake(150, 150);
    UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
    UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imgdata = UIImagePNGRepresentation(resizedImage);
    
    Student_Data *st_data = [[Student_Data alloc]init];
    
//    NSLog(@"save click");
    
    AppDelegate *delegate2 = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSMutableArray *tt_arr = [[NSMutableArray alloc]init];
    
    [tt_arr setArray:[st_data getRecords]];
    
    NSDictionary *dic = tt_arr[delegate2.student_row];
    
    [tt_arr setArray:[st_data getRecords]];
    
    int update_num = [[dic objectForKey:@"no"] intValue];
    
    [st_data upDateWithName:_name_txt.text Birth:_birth_txt.text Phone1:_phone1.text Name2:@"1" Phone2:_phone2.text Name3:@"2" Phone3:_phone3.text Tel:_phone4.text Address:_address.text Memo:_memo.text Img_data:imgdata S_Idno:update_num];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    
}

- (IBAction)edit_btn:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"이미지 가져오기" delegate:self cancelButtonTitle:@"취소하기" destructiveButtonTitle:@"사진찍기" otherButtonTitles:@"사진앨범", nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [actionSheet destructiveButtonIndex]){
        
        self.cameraController = [[UIImagePickerController alloc] init];
        [self.cameraController setDelegate:self];
        [self.cameraController setAllowsEditing:NO];
        [self.cameraController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.cameraController setShowsCameraControls:YES];
        [self.cameraController setEditing:NO];
        
        [self presentViewController:self.cameraController animated:YES completion:nil];
        
    }else if(buttonIndex == [actionSheet firstOtherButtonIndex]){
        
        _cameraController = [[UIImagePickerController alloc]init];
        [_cameraController setDelegate:self];
        [_cameraController setAllowsEditing:YES];
        [_cameraController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:_cameraController animated:YES completion:nil];
        
    }
    
    
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    [picker dismissViewControllerAnimated:YES completion:nil];
//    
//    image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    _face_img.image = image;
//}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}


- (IBAction)textFieldTextDidChange:(id)sender
{
    [self validateTextField:self.phone1];
    //    [self validateTextField:self.name_txtF];
    [self validateTextField:self.phone2];
    [self validateTextField:self.phone3];
    [self validateTextField:self.phone4];
    //    [self validateTextField:self.address];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField == self.phone4) {
        home_num = YES;
    }else{
        home_num = NO;
    }
}

#pragma mark
#pragma mark - UITextField delegates

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text = textField.text;
    NSInteger length = text.length;
    BOOL shouldReplace = YES;
    
    if (home_num == NO) {
        if (![string isEqualToString:@""])
        {
            switch (length)
            {
                case 3:
                case 8:
                    textField.text = [text stringByAppendingString:@"-"];
                    break;
                    
                default:
                    break;
            }
            if (length > 12) shouldReplace = NO;
        }
        else
        {
            switch (length) {
                case 5:
                case 10:
                    textField.text = [text substringWithRange:NSMakeRange(0, length-1)];
                    break;
                    
                default:
                    break;
            }
        }
    }else{
        
        if (![string isEqualToString:@""])
        {
            switch (length)
            {
                case 3:
                case 7:
                    textField.text = [text stringByAppendingString:@"-"];
                    break;
                    
                default:
                    break;
            }
            if (length > 11) shouldReplace = NO;
        }
        else
        {
            switch (length) {
                case 5:
                case 9:
                    textField.text = [text substringWithRange:NSMakeRange(0, length-1)];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    
    
    return shouldReplace;
}

#pragma mark
#pragma mark - Validation

- (void)validateTextField:(UITextField *)textField
{
    // We don't want to do validation on empty string.
    // This is out design here. If you intend to invalidate
    // empty fields -- i.e. fields are required, you can also
    // do the validation on empty string.
    NSString *text = textField.text;
    
    // We use the right view of the text field for feedback
    UIImageView *rightView = (UIImageView *)textField.rightView;
    
    // If user completely deletes a field, we don't want to display anything
    if (!text.length)
    {
        rightView = nil;
    }
    else
    {
        // By default, the right view is nil. If it is nil, it means it the first time
        // we are doing validation on this field, so create an image view and put it there.
        if (!rightView)
        {
            // Create an image view that fits the right view size
            rightView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
            textField.rightView = rightView;
        }
        
        // Perform the validation
        BOOL didValidate = [self validateString:text withPattern:kSocialSecuityNumberPattern];
        
        // Base on whether it validates or not, provide a feedback in UI
        if (didValidate)
        {
            rightView.image = [UIImage imageNamed:@"checkmark.png"];
            textField.rightViewMode = UITextFieldViewModeAlways;
        }
        else
        {
            rightView.image = [UIImage imageNamed:@"exclamation.png"];
            textField.rightViewMode = UITextFieldViewModeAlways;
        }
    }
}

// Validate the input string with the given pattern and
// return the result as a boolean
- (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}


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
        //        self.scroll_view.frame = CGRectMake(0, -keyboardBounds.size.height, self.scroll_view.frame.size.width, self.scroll_view.frame.size.height);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            if (is_iPhone_5) {
                [self.scroll_view setContentSize:CGSizeMake(320, 1550)];
                
            }else{
                [self.scroll_view setContentSize:CGSizeMake(320, 1500)];
                //            [_scrollView setFrame:CGRectMake(0, 20, 320, 480)];
            }
            
        }else{
            
            [self.scroll_view setContentSize:CGSizeMake(768, 1244)];
            
        }
        
        
        
        
        
        
        
        
    }
    else if([notification name] == UIKeyboardWillHideNotification)
    {
        //        [self.view setFrame:CGRectMake(main_View_Frame.origin.x, main_View_Frame.origin.y, main_View_Frame.size.width, main_View_Frame.size.height)];
        //        self.scroll_view.frame = CGRectMake(0, 0, self.scroll_view.frame.size.width, self.scroll_view.frame.size.height);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            //            self.view.center = CGPointMake(160, 240);
            
            if (is_iPhone_5) {
                [self.scroll_view setContentSize:CGSizeMake(320, 1250)];
            }else{
                [self.scroll_view setContentSize:CGSizeMake(320, 1250)];
                //                [self.scroll_view setFrame:CGRectMake(0, 20, 320, 480)];
            }
            
        }else{
            
            [self.scroll_view setContentSize:CGSizeMake(758, 954)];
            
        }
        
    }
    [UIView commitAnimations];
    
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
