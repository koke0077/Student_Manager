//
//  Subject_View.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 15..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Subject_View.h"
#import "Subject_Data.h"
#import "Evolution_Select_View.h"

@interface Subject_View (){
    
    
    UIButton *btn1[10];
    
    NSArray *subject_arr;
    
    NSDictionary *dic;
    
    BOOL isDeleteActive;
    
    UIButton *deleteButton;
    
    NSInteger deletedIndexpath;
}

- (IBAction)add_btn:(UIButton *)sender;

@end

@implementation Subject_View



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    isDeleteActive = NO;
//    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(activateDeletionMode:)];
//    longPress.delegate = self;
//    [self.collectionView addGestureRecognizer:longPress];
//    
//    deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    
    
    
    
                    
}
/*
- (void)activateDeletionMode:(UILongPressGestureRecognizer *)gr
{
    if (gr.state == UIGestureRecognizerStateBegan)
    {
        if(!isDeleteActive){
            UIImage *image = [UIImage imageNamed:@"delete_btn.png"];
            [deleteButton setImage:image forState:UIControlStateNormal];
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[gr locationInView:self.collectionView]];
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
            deletedIndexpath = indexPath.row;
            [cell addSubview:deleteButton];
            [deleteButton bringSubviewToFront:self.collectionView];
        }
    }
}

- (void)delete:(UIButton *)sender
{
    Subject_Data *s_data = [[Subject_Data alloc]init];
    
    NSArray *s_array = [s_data getSubjectName];
    
    NSDictionary *dic = [s_array objectAtIndex:deletedIndexpath];
    
    
//    [self.arrPhotos removeObjectAtIndex:deletedIndexpath];
    [deleteButton removeFromSuperview];
    [self.collectionView reloadData];
}
 */

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    Subject_Data *subject_data = [[Subject_Data alloc]init];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    subject_arr = [subject_data getSubjectName];
//    NSLog(@"collection cnt = %lu",(unsigned long)[subject_arr count]);
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
     return [subject_arr count];
}


//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return [subject_arr count];
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    dic = [subject_arr objectAtIndex:indexPath.row];
    
    NSString *str = [NSString stringWithFormat:@"%@.png",[dic objectForKey:@"subject.Name"]];
    
    UIImageView *img_v = (UIImageView *)[cell viewWithTag:11];
    
    img_v.image = [UIImage imageNamed:str];
    
    return cell;
    
    
}

- (void)deselectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated{
    
    [self sound_btn:@"click"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"EvolutionType"]){
    
    NSArray *arr = [self.collectionView indexPathsForSelectedItems];
    
//    NSLog(@"%d",[[arr objectAtIndex:0] row]);
    
    NSString *str = [[subject_arr objectAtIndex:[[arr objectAtIndex:0]row]]objectForKey:@"subject.Name"];
    
    [[segue destinationViewController] setSubject_name:str];
        [[segue destinationViewController] setSubject_dic:[subject_arr objectAtIndex:
                                                           [[arr objectAtIndex:0]row]]];
    }
}

-(void) sound_btn:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}
-(void) sound_btn2:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}




- (IBAction)add_btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
}
@end
