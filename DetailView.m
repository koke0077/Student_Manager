//
//  DetailView.m
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 21..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "DetailView.h"
#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "Student_Data.h"


#define kSocialSecuityNumberPattern @"^\\d{3}[-]\\d?{3,4}[-]\\d{4}$"
#define kSocialSecuityNumberPattern_2 @"^\\d{3}[-]\?\d{3,4}[-]\\d{4}$"


@interface DetailView (){
    
    BOOL is_Txf;
    
    BOOL is_iPhone_5;
    
    BOOL home_num;
    
    UIImage *image;
    
    AppDelegate *delegate;
    
    CGRect main_View_Frame;
    
    BOOL is_photo;
}

@property (weak, nonatomic) IBOutlet UIButton *address_btn;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@end

@implementation DetailView

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
    
    is_photo = NO;
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
//    _name_txtF.delegate = self;
//    _birth_txtF.delegate = self;
    _phone_1.delegate = self;
    _phone_2.delegate = self;
    _phone_3.delegate = self;
    _phone_4.delegate = self;
//    _address.delegate = self;
    
    NSArray *fields = @[ self.phone_1, self.phone_2, self.phone_3, self.phone_4, self.name_txtF, self.birth_txtF, self.address, self.memo];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
    
    [_scroll_view setScrollEnabled:YES];
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
            is_iPhone_5 = YES;
        }else{
            is_iPhone_5 = NO;
        }
        
        if (is_iPhone_5) {
            [_scroll_view setContentSize:CGSizeMake(320, 1250)];
        }else{
            [_scroll_view setContentSize:CGSizeMake(320, 1340)];
        }

        
    }else{

        self.address_btn.alpha = 0;
        
    }
    
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_name_txtF resignFirstResponder];
    [_birth_txtF resignFirstResponder];
    [_phone_1 resignFirstResponder];
    [_phone_2 resignFirstResponder];
    [_phone_3 resignFirstResponder];
    [_phone_4 resignFirstResponder];
    [_address resignFirstResponder];
    [_memo resignFirstResponder];
    
    
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

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}



- (IBAction)back_btn:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save_btn:(UIButton *)sender {
    [self sound_btn:@"click1"];
    
    Student_Data *st_data = [[Student_Data alloc]init];
    
    if (is_photo == YES) {
        CGSize sacleSize = CGSizeMake(150, 150);
        UIGraphicsBeginImageContextWithOptions(sacleSize, NO, 0.0);
        [image drawInRect:CGRectMake(0, 0, sacleSize.width, sacleSize.height)];
        UIImage * resizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imgdata = UIImagePNGRepresentation(resizedImage);
        
        NSMutableArray *myarray = [[NSMutableArray alloc]init];
        
        [myarray removeAllObjects];
        
        myarray = delegate.face_arr;
        
//        NSLog(@"%@", _name_txtF.text);
        
        [st_data addDataWithName:_name_txtF.text Birth:_birth_txtF.text Phone1:_phone_1.text Name2:@"1" Phone2:_phone_2.text Name3:@"2" Phone3:_phone_3.text Tel:_phone_4.text Address:_address.text Memo:_memo.text Img_data:imgdata];
    }else{
        
        UIImage *img = [UIImage imageNamed:@"basic_face.png"];
        
        NSData *imgdata = UIImagePNGRepresentation(img);
        
//        NSLog(@"%@", _name_txtF.text);
        
        [st_data addDataWithName:_name_txtF.text Birth:_birth_txtF.text Phone1:_phone_1.text Name2:@"1" Phone2:_phone_2.text Name3:@"2" Phone3:_phone_3.text Tel:_phone_4.text Address:_address.text Memo:_memo.text Img_data:imgdata];
    }
    
    
    
//    [delegate addDataWithName:_name_txtF.text Birth:_birth_txtF.text Phone1:_phone_1.text Phone2:_phone_2.text  Phone3:_phone_3.text Phone4:_phone_4.text Address:_address.text Memo:_memo.text Img_data:imgdata];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)img_edit:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"이미지 가져오기" delegate:self cancelButtonTitle:@"취소하기" destructiveButtonTitle:@"사진찍기" otherButtonTitles:@"사진앨범", nil];
    
    [actionSheet showInView:self.view];
}

- (IBAction)address_btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;

	
	[self presentViewController:picker animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [actionSheet destructiveButtonIndex]){
        
        self.cameraController = [[UIImagePickerController alloc] init];
        [self.cameraController setDelegate:self];
        [self.cameraController setAllowsEditing:YES];
        [self.cameraController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.cameraController setShowsCameraControls:YES];
        [self.cameraController setEditing:YES];
        
        self.cameraController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentViewController:self.cameraController animated:YES completion:nil];
        
    }else if(buttonIndex == [actionSheet firstOtherButtonIndex]){
        
        _cameraController = [[UIImagePickerController alloc]init];
        [_cameraController setDelegate:self];
        [_cameraController setAllowsEditing:YES];
        [_cameraController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self.cameraController setEditing:YES];
        
        [self presentViewController:_cameraController animated:YES completion:nil];
        
    }
    
    
}

/*
 -(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
 
 
 
 [picker dismissViewControllerAnimated:YES completion:nil];
 
 NSValue *val =[info objectForKey:UIImagePickerControllerCropRect];
 //    NSLog(@"val = %@", val);
 
 image = [info objectForKey:UIImagePickerControllerEditedImage];
 
 crop_rect = val.CGRectValue;
 
 CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], crop_rect);
 
 
 UIImage *cropped = [UIImage imageWithCGImage:imageRef];
 
 image = cropped;
 
 _imageView.image = image;
 }
 */

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
    
    is_photo = YES;
}

- (UIImage*)imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}


#pragma mark ABPeoplePickerNavigationControllerDelegate

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person{
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    NSString *lastName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if ([firstName isEqual:nil]) {
        _name_txtF.text = [NSString stringWithFormat:@"%@ ", lastName];
    }else{
        _name_txtF.text = [NSString stringWithFormat:@"%@ ", firstName];
    }
    
    
    
    ABMultiValueRef numbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
    
    if (ABMultiValueGetCount(numbers) == 0) // 저장된 번호가 없을 경우 공백으로 표시
        NSLog(@"전화번호 : %@", @"전화번호 없음");
    else
        
        NSLog(@"cont = %ld",ABMultiValueGetCount(numbers));
    int last_num = (int)ABMultiValueGetCount(numbers)-1;
        NSLog(@"전화번호 : %@", (__bridge  NSString*)ABMultiValueCopyValueAtIndex(numbers, last_num));
    
    _phone_1.text = [NSString stringWithFormat:@"%@",
                     (__bridge NSString *)ABMultiValueCopyValueAtIndex(numbers, last_num)];
    

}

// Called after a property has been selected by the user.



- (BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    
    return YES;
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
	[peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)textFieldTextDidChange:(id)sender
{
    [self validateTextField:self.phone_1];
//    [self validateTextField:self.name_txtF];
    [self validateTextField:self.phone_2];
    [self validateTextField:self.phone_3];
    [self validateTextField:self.phone_4];
//    [self validateTextField:self.address];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.keyboardControls setActiveField:textField];
    
    if (textField == self.phone_4) {
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



#pragma mark -
#pragma mark Text Field Delegate

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    [self.keyboardControls setActiveField:textField];
//}

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
                [self.scroll_view setContentSize:CGSizeMake(320, 1340)];
//                [self.scroll_view setFrame:CGRectMake(0, 20, 320, 480)];
            }
            
        }else{
            
             [self.scroll_view setContentSize:CGSizeMake(758, 954)];
            
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
