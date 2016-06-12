//
//  DetailView.h
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 21..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "BSKeyboardControls.h"

#import <AVFoundation/AVFoundation.h>

@interface DetailView : UIViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate, ABPersonViewControllerDelegate, ABPeoplePickerNavigationControllerDelegate,UITextViewDelegate, BSKeyboardControlsDelegate>

- (IBAction)back_btn:(UIButton *)sender;
- (IBAction)save_btn:(UIButton *)sender;
- (IBAction)img_edit:(UIButton *)sender;
- (IBAction)address_btn:(UIButton *)sender;


@property (strong, nonatomic) UIImagePickerController *cameraController;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *face_img;
@property (weak, nonatomic) IBOutlet UITextField *name_txtF;
@property (weak, nonatomic) IBOutlet UITextField *birth_txtF;
@property (weak, nonatomic) IBOutlet UITextField *phone_1;
@property (weak, nonatomic) IBOutlet UITextField *phone_2;
@property (weak, nonatomic) IBOutlet UITextField *phone_3;
@property (weak, nonatomic) IBOutlet UITextField *phone_4;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextView *memo;

@property (strong, nonatomic) AVAudioPlayer *player;








@end
