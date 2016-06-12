//
//  Point_data.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 10. 13..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Point_data : NSObject

-(void) addDataIdnoStudent_idno:(int)students_idno
               BluePoint:(NSString *)bluePoint
           RedPoint:(NSString *)redPoint
             SumPoint:(NSString *)sumPoint
             Reason:(NSString *)reason;

-(void) updateDataStudent_idno:(int)students_idno
                     BluePoint:(NSString *)bluePoint
                   RedPoint:(NSString *)redPoint
                   SumPoint:(NSString *)sumpoint
                     Reason:(NSString *)reason;

-(NSArray *) getPointData;

-(NSArray *) getPointDataStudent_idno:(int)student_idno;

@end
