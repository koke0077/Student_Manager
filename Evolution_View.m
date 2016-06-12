//
//  Evolution_View.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 18..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Evolution_View.h"
#import "Student_Data.h"
#import "Evolution_Data.h"
#import "AppDelegate.h"
#import "Subject_Data.h"


@interface Evolution_View (){

    NSMutableArray *myArray;
    
    NSMutableArray *myArray2;
    
    NSMutableArray *myArray3;
    
    NSArray *e_arr;
    
    BOOL btn1_now;
    
    BOOL btn2_now;
    
    BOOL btn3_now;
    
    UIImage *img1;
    
    UIImage *img2;
    
    NSArray *evoType_arr;
    
    NSString *stt;

    NSMutableArray *s_array;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *evoType;

- (IBAction)delete_btn:(UIButton *)sender;
- (IBAction)output_btn:(UIButton *)sender;
- (IBAction)back_btn:(UIButton *)sender;

@end

@implementation Evolution_View
@synthesize subject, dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    img1 = [UIImage imageNamed:@"point_frame.jpg"];
    img2 = [UIImage imageNamed:@"point_frame_2.jpg"];
    
    btn1_now = NO;
    
    btn2_now = NO;
    
    btn3_now = NO;
    
    self.evoType.text = [dic objectForKey:@"typeName"];
    
    stt = [NSString stringWithFormat:@"%@",[dic objectForKey:@"idno"]];
    
//    NSLog(@"k = %d",[stt intValue]);
    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myArray = [[NSMutableArray alloc]init];
    
    [myArray removeAllObjects];
    
    myArray2 = [[NSMutableArray alloc]init];
    
    [myArray2 removeAllObjects];
    
    myArray3 = [[NSMutableArray alloc]init];
    
    [myArray3 removeAllObjects];
    
    s_array = [NSMutableArray array];
    
    [s_array removeAllObjects];
    
    Student_Data *st_data = [[Student_Data alloc]init];
    
//    [s_array setArray:[st_data getRecords]];
    [s_array setArray:[st_data getNum]];
    
//    Evolution_Data *e_data = [[Evolution_Data alloc]init];
//    
//    e_arr = [e_data getPointWithevoType:[dic objectForKey:@"typeName"]];
    
//    Student_Data *s_data = [[Student_Data alloc]init];
    
    [myArray2 setArray:[st_data getName]];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [myArray2 count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
   
    UILabel *name_lbl = (UILabel *)[cell viewWithTag:11];

    name_lbl.text = [myArray2 objectAtIndex:indexPath.row];
    
    Evolution_Data *e_data = [[Evolution_Data alloc]init];
    
    UIButton *btn1 = [[UIButton alloc]init];
    UIButton *btn2 = [[UIButton alloc]init];
    UIButton *btn3 = [[UIButton alloc]init];
    
    btn1.tag = 1;
    btn2.tag = 2;
    btn3.tag = 3;
    
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

         btn1.frame = CGRectMake(103, 42, 40, 40);
         btn2.frame = CGRectMake(165, 42, 40, 40);
         btn3.frame = CGRectMake(227, 42, 40, 40);
     
     }else{
         btn1.frame = CGRectMake(227, 90, 76, 84);
         btn2.frame = CGRectMake(407, 90, 76, 84);
         btn3.frame = CGRectMake(587, 90, 76, 84);
     }
    
    [cell addSubview:btn1];
    [cell addSubview:btn2];
    [cell addSubview:btn3];
    
    [btn1 addTarget:self action:@selector(one_poin:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(two_poin:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(three_poin:) forControlEvents:UIControlEventTouchUpInside];
    
//    NSDictionary *dic_s = s_array[indexPath.row];
    
//    int s_num = [[dic_s objectForKey:@"no"] intValue];
    
    int s_num = [[s_array objectAtIndex:indexPath.row]intValue];
    
    e_arr = [e_data getPointWithevoType:[dic objectForKey:@"typeName"] StNo:s_num];
    
    if ([e_arr count] == 0) {
        [btn1 setImage:img1 forState:UIControlStateNormal];
        [btn2 setImage:img1 forState:UIControlStateNormal];
        [btn3 setImage:img1 forState:UIControlStateNormal];
    }else{
        
        if ([[e_arr objectAtIndex:0] objectForKey:@"idno"] !=0) {
            if ([[[e_arr objectAtIndex:0] objectForKey:@"idno"] intValue] == 1) {
                [btn1 setImage:img1 forState:UIControlStateNormal];
                [btn2 setImage:img1 forState:UIControlStateNormal];
                [btn3 setImage:img2 forState:UIControlStateNormal];
            }else if ([[[e_arr objectAtIndex:0] objectForKey:@"idno"] intValue] == 2){
                [btn1 setImage:img1 forState:UIControlStateNormal];
                [btn2 setImage:img2 forState:UIControlStateNormal];
                [btn3 setImage:img1 forState:UIControlStateNormal];

            }else if ([[[e_arr objectAtIndex:0] objectForKey:@"idno"] intValue] == 3){
                
                [btn1 setImage:img2 forState:UIControlStateNormal];
                [btn2 setImage:img1 forState:UIControlStateNormal];
                [btn3 setImage:img1 forState:UIControlStateNormal];
            }
        }
    }
    
    
    
    return cell;
}

-(void)three_poin:(id)sender{
    
     [self sound_btn2:@"pik"];
    
    if (btn3_now == NO) {
        
        Evolution_Data *e_data = [[Evolution_Data alloc]init];
        
        Subject_Data *s_data = [[Subject_Data alloc]init];
        
        evoType_arr = [s_data getSubjectTypeName:[dic objectForKey:@"typeName"]];
        
        UIButton *senderButton = (UIButton *)sender;
        UITableViewCell *buttonCell = [self GetCellFromTableView:self.tableView Sender:sender];
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:buttonCell];
        NSInteger rowOfTheCell = [pathOfTheCell row];
        
        [senderButton setImage:img2 forState:UIControlStateNormal];
        
        UITableViewCell *buttonCell2 = (UITableViewCell *)senderButton.superview;
        
        UIButton *b1 = (UIButton *)[buttonCell2.subviews objectAtIndex:3];
        UIButton *b2 = (UIButton *)[buttonCell2.subviews objectAtIndex:4];
        [b1 setImage:img1 forState:UIControlStateNormal];
        [b2 setImage:img1 forState:UIControlStateNormal];
        
        int s_num = [[s_array objectAtIndex:rowOfTheCell] intValue];
        
        e_arr = [e_data getPointWithevoType:[dic objectForKey:@"typeName"] StNo:s_num];
        
        if ([e_arr count] !=0) {
            if ([[e_arr objectAtIndex:0] objectForKey:@"idno"] != nil) {
                [e_data updateEvoIdno:s_num evoType_Idno:[stt intValue] Point:1];
            }else{
                [e_data addEvolutionIdno:s_num evoType_Idno:[stt intValue] Point:1];
            }
        }else{
            [e_data addEvolutionIdno:s_num evoType_Idno:[stt intValue] Point:1];
        }
        
        [senderButton setImage:img2 forState:UIControlStateNormal];

    }else{
        
    }
    
    [self.tableView reloadData];
    
}

-(UITableViewCell*)GetCellFromTableView:(UITableView*)tableView Sender:(id)sender {
    CGPoint pos = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:pos];
    return [tableView cellForRowAtIndexPath:indexPath];
}

-(void)two_poin:(id)sender{
    
     [self sound_btn2:@"pik"];
    
    if (btn2_now == NO) {
        
//        NSIndexPath *path = [self GetCellFromTableView:self.tableView Sender:sender];
        
//        NSLog(@"path = %@", path);
        
        UIButton *senderButton = (UIButton *)sender;
        UITableViewCell *buttonCell = [self GetCellFromTableView:self.tableView Sender:sender];
        //    UITableView* table = (UITableView *)[buttonCell superview];
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:buttonCell];
        NSInteger rowOfTheCell = [pathOfTheCell row];
        
        [senderButton setImage:img2 forState:UIControlStateNormal];
        
        UITableViewCell *buttonCell2 = (UITableViewCell *)senderButton.superview;
        
        UIButton *b1 = (UIButton *)[buttonCell2.subviews objectAtIndex:3];
        UIButton *b3 = (UIButton *)[buttonCell2.subviews objectAtIndex:5];
        [b1 setImage:img1 forState:UIControlStateNormal];
        [b3 setImage:img1 forState:UIControlStateNormal];
        
//        NSDictionary *dic_s = s_array[rowOfTheCell];
        
//        int s_num = [[dic_s objectForKey:@"no"] intValue];
        int s_num = [[s_array objectAtIndex:rowOfTheCell] intValue];
        
        Evolution_Data *e_data = [[Evolution_Data alloc]init];
        
        e_arr = [e_data getPointWithevoType:[dic objectForKey:@"typeName"] StNo:s_num];
        
        if ([e_arr count] !=0) {
            if ([[e_arr objectAtIndex:0] objectForKey:@"idno"] != nil) {
                [e_data updateEvoIdno:s_num evoType_Idno:[stt intValue] Point:2];
            }else{
                [e_data addEvolutionIdno:s_num evoType_Idno:[stt intValue] Point:2];
            }
        }else{
            [e_data addEvolutionIdno:s_num evoType_Idno:[stt intValue] Point:2];
        }

    }else{
        
    }
    
    [self.tableView reloadData];
}

-(void)one_poin:(id)sender{
    
    [self sound_btn2:@"pik"];
    
    if (btn1_now == NO) {
        
        UIButton *senderButton = (UIButton *)sender;
        UITableViewCell *buttonCell = [self GetCellFromTableView:self.tableView Sender:sender];
        //    UITableView* table = (UITableView *)[buttonCell superview];
        NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:buttonCell];
        NSInteger rowOfTheCell = [pathOfTheCell row];
        
        [senderButton setImage:img2 forState:UIControlStateNormal];
        
        UITableViewCell *buttonCell2 = (UITableViewCell *)senderButton.superview;
        [senderButton setImage:img2 forState:UIControlStateNormal];
        
        UIButton *b2 = (UIButton *)[buttonCell2.subviews objectAtIndex:4];
        UIButton *b3 = (UIButton *)[buttonCell2.subviews objectAtIndex:5];
        [b2 setImage:img1 forState:UIControlStateNormal];
        [b3 setImage:img1 forState:UIControlStateNormal];
        
//        NSDictionary *dic_s = s_array[rowOfTheCell];
        
//        int s_num = [[dic_s objectForKey:@"no"] intValue];
        int s_num = [[s_array objectAtIndex:rowOfTheCell] intValue];
        
        Evolution_Data *e_data = [[Evolution_Data alloc]init];
        
//        NSLog(@" 영역번호 : %d", (int)[dic objectForKey:@"Subject_idno"]);
        
        e_arr = [e_data getPointWithevoType:[dic objectForKey:@"typeName"] StNo:s_num];
        
        if ([e_arr count] !=0) {
            if ([[e_arr objectAtIndex:0] objectForKey:@"idno"] != nil) {
                [e_data updateEvoIdno:s_num evoType_Idno:[stt intValue] Point:3];
            }else{
                [e_data addEvolutionIdno:s_num evoType_Idno:[stt intValue] Point:3];
            }
        }else{
            [e_data addEvolutionIdno:s_num evoType_Idno:[stt intValue] Point:3];
        }
        
    }else{
        
    }
    
    [self.tableView reloadData];
}

- (IBAction)delete_btn:(UIButton *)sender {
    

}

- (IBAction)output_btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];

    NSMutableArray *firstArray;
    NSArray *secondArray;//, *thirdArray;
    
    Student_Data *s_data = [[Student_Data alloc]init];
    
//    Subject_Data *j_data = [[Subject_Data alloc]init];
    
    Evolution_Data *e_data = [[Evolution_Data alloc]init];
    
    firstArray = [[NSMutableArray alloc]init];
    
    [firstArray removeAllObjects];
    
    NSArray *stu_data = [s_data getRecords];
    
    NSDictionary *s_dic[[stu_data count]];
    
    for (int i = 0; i < [stu_data count]; i++) {
        s_dic[i] = [[stu_data objectAtIndex:i] objectForKey:@"name"];
        
    }
    
    for (int i = 0; i<[stu_data count]; i++) {
        [firstArray addObject:s_dic[i]];
    }
    
    secondArray = [e_data getPointWithevoType:[dic objectForKey:@"typeName"]];
    

    
    NSMutableString *csv = [NSMutableString stringWithString:@"Name,점수"];
    
    NSUInteger count = [firstArray count];
    
    if (count == [secondArray count]) {
        for (NSUInteger i=0; i<count; i++ ) {
            [csv appendFormat:@"\n\"%@\",\"%d\"",
             [firstArray objectAtIndex:i],
             [[secondArray objectAtIndex:i]intValue]];
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        NSString *root = [documentsDir stringByAppendingPathComponent:@"evolution.csv"];
        NSError *error;
        BOOL res = [csv writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        if (!res) {
            NSLog(@"Error %@ while writing to file %@", [error localizedDescription], csv );
        }else{
        }
    }
    
    [self showEmail:@"evolution.csv"];
    
    
}

- (void)showEmail:(NSString*)file {
    
    NSString *emailTitle = @" 수행평가 점수";
    NSString *messageBody = @"첨부파일을 다운 받아 보세요.";
    NSArray *toRecipents = [NSArray arrayWithObject:@"메일 주소를 적어주세요"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Determine the file name and extension
    NSArray *filepart = [file componentsSeparatedByString:@"."];
//    NSString *filename = [filepart objectAtIndex:0];
    NSString *extension = [filepart objectAtIndex:1];
    
    // Get the resource path and read the file using NSData
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    NSString *root = [documentsDir stringByAppendingPathComponent:@"evolution.csv"];
    NSData *fileData = [NSData dataWithContentsOfFile:root];
    
    // Determine the MIME type
    NSString *mimeType;
    if ([extension isEqualToString:@"jpg"]) {
        mimeType = @"image/jpeg";
    } else if ([extension isEqualToString:@"png"]) {
        mimeType = @"image/png";
    } else if ([extension isEqualToString:@"doc"]) {
        mimeType = @"application/msword";
    } else if ([extension isEqualToString:@"ppt"]) {
        mimeType = @"application/vnd.ms-powerpoint";
    } else if ([extension isEqualToString:@"html"]) {
        mimeType = @"text/html";
    } else if ([extension isEqualToString:@"pdf"]) {
        mimeType = @"application/pdf";
    }else if ([extension isEqualToString:@"csv"])   {
        mimeType = @"excel/evolution.csv";
    }
    
    NSString *filename2 = @"evolution.csv";
    
    // Add attachment
    [mc addAttachmentData:fileData mimeType:mimeType fileName:filename2];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)back_btn:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self.navigationController popViewControllerAnimated:YES];
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


@end
