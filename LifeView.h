//
//  LifeView.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 13..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LifeView : UIViewController

@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
