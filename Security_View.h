//
//  Security_View.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Security_View : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txt_f;
@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)no_btn:(UIButton *)sender;
- (IBAction)yes_btn:(UIButton *)sender;

@end
