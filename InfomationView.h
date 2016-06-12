//
//  InfomationView.h
//  Students_Management
//
//  Created by kimsung jun on 2014. 3. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface InfomationView : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)btn_delete:(UIButton *)sender;

- (IBAction)btn:(id)sender;
@end
