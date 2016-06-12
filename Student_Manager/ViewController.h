//
//  ViewController.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 19..
//  Copyright (c) 2014년 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *first_Btn;
@property (weak, nonatomic) IBOutlet UIButton *second_Btn;

@property (strong, nonatomic) AVAudioPlayer *player;

@end
