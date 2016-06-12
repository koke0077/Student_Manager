//
//  ConsultingView.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <AVFoundation/AVFoundation.h>

@interface ConsultingView : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) AVAudioPlayer *player;
@end
