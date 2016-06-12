//
//  Subject_selectView.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 16..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface Subject_selectView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;

@end
