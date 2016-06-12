//
//  Subject_Data.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 16..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Subject_Data.h"
#import <sqlite3.h>

@interface Subject_Data (){
    
    
}

@end

@implementation Subject_Data

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getDb{
    
    

}

-(void) addSubjectWithIDno:(int)idno Subject_Name:(NSString *)subject_name{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    char *sql = "INSERT INTO subject (idno, name) VALUES(?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_int(statement, 1, idno);
        sqlite3_bind_text(statement, 2, [subject_name UTF8String], -1, SQLITE_TRANSIENT);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);

    
}

-(void) deleteWithSubject:(NSString *)subject{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"delete from subject where subject.name = '[%@]'",subject]
                         UTF8String];
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void) addSubjectTypeIdno:(int)idno Subject_idno:(int)subject_idno TypeName:(NSString *)typeName{
 
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    int period = [[userdefaults objectForKey:@"period"] intValue];
    
    char *sql = "INSERT INTO evolutionType (idno, Period_idno, Subject_idno, typeName) VALUES(?,?,?,?)";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_int(statement, 1, idno);
        sqlite3_bind_int(statement, 2, period);
        sqlite3_bind_int(statement, 3, subject_idno);
        sqlite3_bind_text(statement, 4, [typeName UTF8String], -1, SQLITE_TRANSIENT);
        
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void) deleteSubjectType:(NSString *)subjectType Idno:(int)idno{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"delete from evolution where evolution.EvolutionType_idno = %d",idno]
                         UTF8String];
    
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK){

    }
    
    
    char *sql2 = (char *)[[NSString stringWithFormat:
                          @"delete from evolutionType where evolutionType.typeName = '%@'",subjectType]
                         UTF8String];
    

    if (sqlite3_prepare_v2(database, sql2 , -1, &statement, NULL) == SQLITE_OK){

    }
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    

}

-(void) deleteSubjectIdno:(int)idno{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"delete from evolution where evolution.EvolutionType_idno = %d",idno]
                         UTF8String];
    
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK){
        
    }
    
    
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

-(NSArray *)getSubjectName{
    
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }

//    NSLog(@"%@", data_Path);
    
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    char *sql = "SELECT idno, subject.name FROM subject";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"idno",
                                 [NSString stringWithUTF8String:
                                  (char *)sqlite3_column_text(statement, 1)],@"subject.Name",
                                 nil];
            
            [Result addObject:dic];
        }
    }
    
    
    
    return Result;
    
}

-(NSArray *) getSubjectTypeName:(NSString *)name{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    
    int period = [[userdefaults objectForKey:@"period"] intValue];
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"select evolutionType.typeName, evolutionType.idno from evolutionType, subject where evolutionType.Subject_idno = subject.idno and subject.name = '%@' and evolutionType.Period_idno=%d",name, period] UTF8String];

//    char *sql = "select evolutionType.typeName from evolutionType, subject where evolutionType.Subject_idno = subject.idno and subject.name = '국어'";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithUTF8String:
                                  (char *)sqlite3_column_text(statement, 0)],@"typeName",
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 1)],@"idno",
                                 nil];
            
            [Result addObject:dic];
        }
    }
    return Result;
}

-(int) getSubjectTypeIdnoWithSubjectName:(NSString *)subjectname{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return 0;
    }
    
    NSLog(@"%@", data_Path);
    

    int idno;
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"SELECT evolutionType.idno FROM evolutionType where evolutionType.typeName = '%@'",subjectname] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            idno = [[NSNumber numberWithInt:sqlite3_column_int(statement, 0)] intValue];
        }
    }
    return idno;
}

@end
