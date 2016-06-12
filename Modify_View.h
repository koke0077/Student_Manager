//
//  Modify_View.h
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"
#import <AVFoundation/AVFoundation.h>

@interface Modify_View : UIViewController<UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate, BSKeyboardControlsDelegate>{
    
   NSArray *myArray;
}

- (IBAction)back:(UIButton *)sender;

- (IBAction)save:(UIButton *)sender;

- (IBAction)edit_btn:(UIButton *)sender;

@property (nonatomic) NSInteger row_num;

@property (strong, nonatomic) NSMutableDictionary *dic;

@property (weak, nonatomic) IBOutlet UIImageView *face_img;

@property (strong, nonatomic) UIImagePickerController *cameraController;

@property (weak, nonatomic) IBOutlet UITextField *name_txt;

@property (weak, nonatomic) IBOutlet UITextField *birth_txt;

@property (weak, nonatomic) IBOutlet UITextField *phone1;

@property (weak, nonatomic) IBOutlet UITextField *phone2;

@property (weak, nonatomic) IBOutlet UITextField *phone3;

@property (weak, nonatomic) IBOutlet UITextField *phone4;

@property (weak, nonatomic) IBOutlet UITextField *address;

@property (weak, nonatomic) IBOutlet UITextView *memo;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll_view;

@property (weak, nonatomic) IBOutlet UIView *view2;

@property (strong, nonatomic) AVAudioPlayer *player;

@property (nonatomic, strong) NSArray *myArray;


@end
