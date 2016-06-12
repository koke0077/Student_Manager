//
//  Evolution_Select_View.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

@interface Evolution_Select_View : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    NSString *subject_name;
    
    NSDictionary *subject_dic;
}
@property (strong, nonatomic) AVAudioPlayer *player;

@property (nonatomic, strong) NSString *subject_name;

@property (nonatomic, strong) NSDictionary *subject_dic;

@end
