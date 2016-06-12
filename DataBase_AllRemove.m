//
//  DataBase_AllRemove.m
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "DataBase_AllRemove.h"
#import <sqlite3.h>

@implementation DataBase_AllRemove


-(void)data_all_remove{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *dbPath = [data_document stringByAppendingPathComponent:@"Student_Data.sqlite"];
    
//    NSLog(@"%@", dbPath);
    
    if (sqlite3_open([dbPath UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    char *sql = "delete from students";
    
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK){
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"학생 데이터 삭제 오류");
        }
        
    }
    
    char *sql2 = "delete from subject";
    
    
    if (sqlite3_prepare_v2(database, sql2 , -1, &statement, NULL) == SQLITE_OK){
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"과목 데이터 삭제 오류");
        }
        
    }
    
    char *sql3 = "delete from point";
    
    
    if (sqlite3_prepare_v2(database, sql3 , -1, &statement, NULL) == SQLITE_OK){
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"상점 데이터 삭제 오류");
        }
        
    }
    
    char *sql4 = "delete from period";
    
    
    if (sqlite3_prepare_v2(database, sql4 , -1, &statement, NULL) == SQLITE_OK){
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"학기 데이터 삭제 오류");
        }
        
    }
    
    char *sql5 = "delete from evolutionType";
    
    
    if (sqlite3_prepare_v2(database, sql5 , -1, &statement, NULL) == SQLITE_OK){
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"평가영역 데이터 삭제 오류");
        }
        
    }
    
    char *sql6 = "delete from evolution";
    
    
    if (sqlite3_prepare_v2(database, sql6 , -1, &statement, NULL) == SQLITE_OK){
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"평가점수 데이터 삭제 오류");
        }
        
    }
    
    char *sql7 = "delete from consultingInfo";
    
    
    if (sqlite3_prepare_v2(database, sql7 , -1, &statement, NULL) == SQLITE_OK){
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"상담 데이터 삭제 오류");
        }
        
    }
    
    
    
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);


    
}

@end
