//
//  Show_View.h
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Show_View : UIViewController<UITextViewDelegate, UIActionSheetDelegate>

@property (nonatomic) NSInteger row_num;

@property (strong, nonatomic) NSDictionary *dic;
@property (weak, nonatomic) IBOutlet UIImageView *face_img;
@property (weak, nonatomic) IBOutlet UILabel *name_label;
@property (weak, nonatomic) IBOutlet UILabel *birth_label;
@property (weak, nonatomic) IBOutlet UIButton *phone1;
@property (weak, nonatomic) IBOutlet UIButton *phone2;
@property (weak, nonatomic) IBOutlet UIButton *phone3;
@property (weak, nonatomic) IBOutlet UIButton *phone4;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UITextView *memo;

@property (strong, nonatomic) AVAudioPlayer *player;

//@property (strong, nonatomic) NSMutableArray *myArray;

@property (weak, nonatomic) IBOutlet UIScrollView *scorll_view;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *bg_img;

- (IBAction)back:(UIButton *)sender;
- (IBAction)edit:(UIButton *)sender;



@end
