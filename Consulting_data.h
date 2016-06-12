//
//  Consulting_data.h
//  Student_Manager
//
//  Created by kimsung jun on 2014. 8. 21..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Consulting_data : NSObject

-(void) addDataIdno:(int)idno
       Student_idno:(int)student_idno
               Date:(NSString *)date
           Location:(NSString *)location
             Motive:(NSString *)motive
             Method:(NSString *)method
           Category:(NSString *)category
              Story:(NSString *)story;

-(NSArray *) getConsultingData;

-(NSArray *) getConsultingDataStudent_idno:(int)student_idno;

@end
