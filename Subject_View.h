//
//  Subject_View.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 15..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Subject_View : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate>


@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
