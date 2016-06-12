//
//  Evolution_View.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

#import <AVFoundation/AVFoundation.h>

@interface Evolution_View : UIViewController<UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>{
    
    NSString *subject;
    
    NSDictionary *dic;
}

@property (strong, nonatomic) AVAudioPlayer *player;

@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSDictionary *dic;

@end
