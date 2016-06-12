//
//  Security_Option.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Security_Option : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txt_f;
@property (weak, nonatomic) IBOutlet UITextField *txt_f2;

@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIButton *conform_Btn;
- (IBAction)btn:(UIButton *)sender;

@end
