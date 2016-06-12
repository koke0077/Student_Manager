//
//  ConsultingView.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "ConsultingView.h"
#import "Student_Data.h"
#import "Consulting_data.h"
#import "AppDelegate.h"
#import "ConsultingShow.h"
#import "ConsultingReadView.h"

@interface ConsultingView (){
    
    NSMutableArray *myArray;
    
    NSMutableArray *myArray2;
    
    UIView *v2;

    NSDictionary *dic;
    
    NSMutableArray *s_array;
    
    UILabel *name_lbl;
    
    int com_row;

}
- (IBAction)ouput_consulting_btn:(UIButton *)sender;

@end

@implementation ConsultingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    Student_Data *st_data = [[Student_Data alloc]init];
    
    myArray = [[NSMutableArray alloc]init];
    
    [myArray removeAllObjects];
    
//    [myArray setArray:[st_data getRecords]];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myArray = delegate.face_arr;
    
//    NSLog(@"consulting myarray %lu", (unsigned long)[myArray count]);
    
    myArray2 = [NSMutableArray arrayWithCapacity:0]; //myArray2 초기화
    for (int a = 0; a < myArray.count; a++) {       //myArray2 초기화
        [myArray2 addObject:@"0"];                   //myArray2 초기화
    }
    
   
    
    [self.tableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [myArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[myArray2 objectAtIndex:section] isEqualToString:@"0"]) {
        return 0;
    } else {
        

        Consulting_data *consulting_data = [[Consulting_data alloc]init];
        
        
        NSArray* members = [consulting_data getConsultingDataStudent_idno:(int)section];
        
        return [members count];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Consulting_data *consulting_data = [[Consulting_data alloc]init];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSArray* members = [consulting_data getConsultingDataStudent_idno:(int)indexPath.section];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    NSLog(@"indexPath.section %d" , (int)indexPath.section);
    
//    NSLog(@"%d", (int)[[members objectAtIndex:indexPath.section] objectForKey:@"Students_idno"]);
    
//    if (indexPath.section+1 == (int)[[members objectAtIndex:indexPath.section] objectForKey:@"Students_idno"]) {
//        
//        
//        
//       
//    }
    
    
    delegate.consulting_data = [members objectAtIndex:indexPath.row];
    
    ConsultingReadView * v1 = [self.storyboard instantiateViewControllerWithIdentifier:@"reading"];
    
    v1.dic_dic = [members objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:v1 animated:YES];
    
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *button_View;
    
    UILabel *consult_name;
    
    UILabel *consulting_count;
    
    UILabel *consulting_count2 ;
    
    UILabel *consult_datelabel;
    
    UILabel *consult_date;
    
    UIButton* buttonA;
    
    UIImageView *face_img ;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
     dic = [delegate.face_arr objectAtIndex:section];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        button_View = [[UIView alloc]initWithFrame:CGRectMake(0, 20, 320, 120)];
        consult_name = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 80, 40)];
        consulting_count = [[UILabel alloc]initWithFrame:CGRectMake(120, 55, 80, 30)];
        consulting_count2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 55, 40, 30)];
        consult_datelabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 90, 120, 30)];
        consult_date = [[UILabel alloc]initWithFrame:CGRectMake(220, 90, 80, 30)];
        buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonA.frame = CGRectMake(0, 20, 280, 120);
        UIImage *img = [UIImage imageWithData:[dic objectForKey:@"img_data"]];
        face_img = [[UIImageView alloc]initWithImage:img];
        face_img.frame = CGRectMake(10, 10, 100, 100);
        
        
    }else{
        
        button_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 240)];
        consult_name = [[UILabel alloc]initWithFrame:CGRectMake(250, 87, 160, 65)];
        consulting_count = [[UILabel alloc]initWithFrame:CGRectMake(430, 41, 110, 40)];
        consulting_count2 = [[UILabel alloc]initWithFrame:CGRectMake(540, 41, 110, 40)];
        consult_datelabel = [[UILabel alloc]initWithFrame:CGRectMake(328, 179, 135, 41)];
        consult_date = [[UILabel alloc]initWithFrame:CGRectMake(471, 179, 237, 41)];
        buttonA = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonA.frame = CGRectMake(20, 20, 728, 240);
        UIImage *img = [UIImage imageWithData:[dic objectForKey:@"img_data"]];
        face_img = [[UIImageView alloc]initWithImage:img];
        face_img.frame = CGRectMake(20, 20, 200, 200);

        
    }
    
    
    [button_View setBackgroundColor:[UIColor  whiteColor]];
    
        [button_View addSubview:face_img];
    
    // 이름
    
    consult_name.text = [[myArray objectAtIndex:section] objectForKey:@"name"];
    
    consult_name.adjustsFontSizeToFitWidth = YES;
    
    [button_View addSubview:consult_name];
    
    //상담횟수 이름
    
    consulting_count. text = @"count : ";
    
    consulting_count.textColor = [UIColor orangeColor];
    
    [button_View addSubview:consulting_count];
    
    //상담횟수
    
    Consulting_data *consulting_data = [[Consulting_data alloc]init];
    
    NSArray* members = [consulting_data getConsultingDataStudent_idno:(int)section];
    
    consulting_count2.text = [NSString stringWithFormat:@"%d ",(int)[members count]];
    
    consulting_count2.textColor = [UIColor orangeColor];
    
    [button_View addSubview:consulting_count2];
    
    //최근 상담일
    
    consult_datelabel. text = @"new date. : ";
    
    consult_datelabel.textColor = [UIColor blueColor];
    
    [button_View addSubview:consult_datelabel];
    
    consult_date.numberOfLines = 2;
    
    consult_date.text = [[members lastObject] objectForKey:@"date"];
    
    consult_date.adjustsFontSizeToFitWidth = YES;
    
    consult_date.textColor = [UIColor blueColor];
    
    [button_View addSubview:consult_date];
    
    
    //지브라뷰 버튼
    
//    buttonA.titleLabel.textColor = [UIColor blackColor];
    
//    [buttonA setTitle:[[myArray objectAtIndex:section] objectForKey:@"name"]
//             forState:UIControlStateNormal];
    
//    UIImage *img = [UIImage imageNamed:@"section_frame.png"];
//    [buttonA setImage:img forState:UIControlStateNormal];
    buttonA.tag = section;
    
//    NSLog(@"tag = %d", buttonA.tag);
    [buttonA addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* buttonB = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
 
    //    [buttonA setImage:[imgArray objectAtIndex:section] forState:UIControlStateNormal];
//    buttonB.tag = section;
    [buttonB addTarget:self action:@selector(buttonPressed2:) forControlEvents:UIControlEventTouchUpInside];
    
    buttonB.tag = section;
    
    [button_View addSubview:buttonA];
    [button_View addSubview:buttonB];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        buttonB.center = CGPointMake(button_View.frame.size.width-30, button_View.frame.size.height/2);

    }else{
        
        buttonB.center = CGPointMake(button_View.frame.size.width-100, button_View.frame.size.height/2);
        
    }

    return button_View;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {

        return 120.0f;
        
    }else{
        
        return 240.0f;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* CellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    Consulting_data *consulting_data = [[Consulting_data alloc]init];
  
    NSArray* members = [consulting_data getConsultingDataStudent_idno:(int)indexPath.section];
    
    cell.textLabel.text = [[members objectAtIndex:indexPath.row] objectForKey:@"motive"];
//    cell.detailTextLabel.text = [[members objectAtIndex:indexPath.row] objectForKey:@"date"];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0];
        
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSString* aKey = [myArray2 objectAtIndex:sender.tag];
    
    if ([aKey isEqualToString:@"0"]) {
        [myArray2 replaceObjectAtIndex:sender.tag withObject:@"1"];
        [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [myArray2 replaceObjectAtIndex:sender.tag withObject:@"0"];
        [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
}

- (void)buttonPressed2:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    ConsultingView * v1 = [self.storyboard instantiateViewControllerWithIdentifier:@"show"];
    
    [self.navigationController pushViewController:v1 animated:YES];
    
    delegate.consultion_Section = (int)sender.tag;
    
//    NSLog(@"sender.tag = %ld", (long)sender.tag);
    
}



- (IBAction)ouput_consulting_btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    self.tableview.userInteractionEnabled = NO;
    v2 = [[UIView alloc]initWithFrame:CGRectMake(0, -320, 320, 320)];
    v2.backgroundColor = [UIColor clearColor];
    
    UIImage *img_bg = [UIImage imageNamed:@"option_bg.png"];
    UIImageView *option_img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 320)];
    option_img.image = img_bg;
    [v2 addSubview:option_img];
    
   UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 130, 320, 170)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    [v2 addSubview:pickerView];
    
    name_lbl = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 100, 50)];
    name_lbl.font = [UIFont boldSystemFontOfSize:25.0];
    name_lbl.textAlignment = 1;
    [v2 addSubview:name_lbl];
    
    UIButton *save_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btn_img2 = [UIImage imageNamed:@"output_btn.png"];
    [save_btn setBackgroundImage:btn_img2 forState:UIControlStateNormal];
    [save_btn setBackgroundColor:[UIColor clearColor]];
    [save_btn setFrame:CGRectMake(230, 50, 70, 50)];
    [save_btn addTarget:self action:@selector(save_act) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:save_btn];
    
    UIButton *remove_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *btn_img = [UIImage imageNamed:@"cancel_btn.png"];
    [remove_btn setImage:btn_img forState:UIControlStateNormal];
    [remove_btn setBackgroundColor:[UIColor clearColor]];
    [remove_btn setFrame:CGRectMake(20, 50, 70, 50)];
    [remove_btn addTarget:self action:@selector(remove_act) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:remove_btn];
    
    [self.view addSubview:v2];
    [self option_animationDown];
}

-(void) save_act{
    
    [self sound_btn2:@"pik"];
    
//     NSLog(@"com_row = %d",com_row);
    
    [self.tableview setUserInteractionEnabled:YES];
    [self option_animationUp];
    
    NSMutableArray *firstArray;
    NSArray *secondArray;//, *thirdArray;
    
    Student_Data *s_data = [[Student_Data alloc]init];
    
    Consulting_data *c_data = [[Consulting_data alloc]init];
    
    firstArray = [[NSMutableArray alloc]init];
    
    [firstArray removeAllObjects];
    
//    NSArray *stu_data = [s_data getRecords];
//    
//    NSDictionary *s_dic;
    
    NSDictionary *dic_s = s_array[com_row];
    
    int s_num = [[dic_s objectForKey:@"no"] intValue];
    
    secondArray = [c_data getConsultingDataStudent_idno:s_num];
    
    s_array = [NSMutableArray array];
    
    [s_array removeAllObjects];
    
    [s_array setArray:[s_data getRecords]];
    
    
    NSMutableString *csv = [NSMutableString stringWithFormat:@"이름, 상담일, 상담장소, 상담동기, 상담방법, 상담분류, 상담내용"];
    
//    NSUInteger count = [firstArray count];
    
    if ([secondArray count] ) {
        // provided all arrays are of the same length
        for (NSUInteger i=0; i<[secondArray count]; i++ ) {
            [csv appendFormat:@"\n\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\"",
             [[myArray objectAtIndex:com_row] objectForKey:@"name"],
             [[secondArray objectAtIndex:i] objectForKey:@"date"],
             [[secondArray objectAtIndex:i] objectForKey:@"location"],
             [[secondArray objectAtIndex:i] objectForKey:@"motive"],
             [[secondArray objectAtIndex:i] objectForKey:@"method"],
             [[secondArray objectAtIndex:i] objectForKey:@"category"],
             [[secondArray objectAtIndex:i] objectForKey:@"story"]];
            // instead of integerValue may be used intValue or other, it depends how array was created
        }
        
//        NSLog(@"%@",csv);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        NSString *root = [documentsDir stringByAppendingPathComponent:@"consulting.csv"];
        
        NSError *error;
        BOOL res = [csv writeToFile:root atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        
        if (!res) {
            NSLog(@"Error %@ while writing to file %@", [error localizedDescription], csv );
        }else{
            
            
        }
    }
    
    [self showEmail:@"consulting.csv"];

}

-(void) remove_act{
    
    [self sound_btn:@"click2"];
    
    [self.tableview setUserInteractionEnabled:YES];
    
    [self option_animationUp];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
        return [myArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[myArray objectAtIndex:row] objectForKey:@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        for (int i= 0; i < [myArray count]; i++) {
            if (row  == i) {
                name_lbl.text = [[myArray objectAtIndex:row] objectForKey:@"name"];
                
                com_row = i;
            }
        }
    }
}



-(void) option_animationUp{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.5];
    v2.frame = CGRectMake(0, 0, 320, 320);
    [UIView commitAnimations];
    v2.center = CGPointMake(160, 160);
    [UIView animateWithDuration:0.5
                     animations:^{
                         v2.center = CGPointMake(160, -160);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                          }];
                         [v2 removeFromSuperview];
                     }];
}

-(void) option_animationDown{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    v2.frame = CGRectMake(0, -320, 320, 320);
    [UIView commitAnimations];
    [UIView animateWithDuration:0.5
                     animations:^{
                         v2.center = CGPointMake(160, 160);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                          animations:^{
                                          }];
                     }];
}


- (IBAction)output_btn:(UIButton *)sender {
    
    
    
}

- (void)showEmail:(NSString*)file {
    
    NSString *emailTitle = @"면담 기록";
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
    NSString *root = [documentsDir stringByAppendingPathComponent:@"consulting.csv"];
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
    
    NSString *filename2 = @"consulting.csv";
    
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
