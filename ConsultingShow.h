//
//  ConsultingShow.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 22..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"
#import <AVFoundation/AVFoundation.h>

@interface ConsultingShow : UIViewController<UITextFieldDelegate, UITextViewDelegate,  BSKeyboardControlsDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;

@end
