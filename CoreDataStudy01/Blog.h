//
//  Blog.h
//  CoreDataStudy01
//
//  Created by 布川祐人 on 2014/04/26.
//  Copyright (c) 2014年 NUNOKAWA Masato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Article;

@interface Blog : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *article;
@end

@interface Blog (CoreDataGeneratedAccessors)

- (void)addArticleObject:(Article *)value;
- (void)removeArticleObject:(Article *)value;
- (void)addArticle:(NSSet *)values;
- (void)removeArticle:(NSSet *)values;

@end
