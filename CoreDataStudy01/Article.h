//
//  Article.h
//  CoreDataStudy01
//
//  Created by 布川祐人 on 2014/04/26.
//  Copyright (c) 2014年 NUNOKAWA Masato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Article : NSManagedObject

@property (nonatomic, retain) NSString * title;

@end
