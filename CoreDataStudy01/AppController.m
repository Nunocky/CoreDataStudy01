//
//  AppController.m
//  CoreDataStudy01
//
//  Created by 布川祐人 on 2014/04/26.
//  Copyright (c) 2014年 NUNOKAWA Masato. All rights reserved.
//

#import "AppController.h"


#import "Article.h"
#import "Blog.h"

@implementation AppController

-(void)applicationDidFinishLaunching
{

}

- (IBAction)buttonClicked:(id)sender {
    // データベースの内容を出力
    NSMutableString *str = [NSMutableString string];
    NSArray *blogs = [self allBlogs];
    for (Blog *blog in blogs) {
        for (Article *article in blog.article) {
            //NSLog(@"%@", article.title);
            [str appendString:article.title];
            [str appendString:@"\n"];
        }
    }
    
    self.text = str;
}

- (IBAction)button2Clicked:(id)sender {
    // 各Blogの要素を一個削除
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSError *error;

    NSArray *blogs = [self allBlogs];
    for (Blog *blog in blogs) {
        NSSet *articles = blog.article;
        Article *article = [articles anyObject];
        if (article) {
            [context deleteObject:article];
        }
    }
    
    if ([context save:&error] == NO) {
        NSLog(@"%@", [error description]);
    }

}
- (IBAction)button3Clicked:(id)sender {
    [self createSampleDatabase];
}

- (IBAction)button4Clicked:(id)sender {
    [self removeAllData];
}


#pragma mark Database
-(void)createSampleDatabase
{
    for (NSString *title in @[@"blog1", @"blog2", @"blog3"]) {
        Blog *blog;
        Article *article;
        
        blog = [self insertNewBlog:title];
        
        for (int i=0; i<3; i++) {
            NSString *articleTitle = [NSString stringWithFormat:@"%@ : %d", title, i];
            article = [self insertNewArticleWithTitle:articleTitle];
            [blog addArticleObject:article];
        }
    }
}

-(void)removeAllData
{
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSError *error;

    for (Blog *blog in [self allBlogs]) {
        [context deleteObject:blog];
    }
 
    if ([context save:&error] == NO) {
        NSLog(@"%@", [error description]);
    }

}

#pragma mark Blog

-(NSArray*)allBlogs
{
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSError *error;
    NSArray *result;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Blog"];
    result = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    return result;
}

-(Blog*)insertNewBlog:(NSString*)title {
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSError *error;
    Blog *blog;

    blog = [self blogWithTitle:title];

    if (blog){
        //NSLog(@"Blog %@ already exists", title);
        return blog;
    }
    
    blog = [NSEntityDescription insertNewObjectForEntityForName:@"Blog"
                                         inManagedObjectContext:context];
    
    blog.title = [title copy];
    
    if ([context save:&error] == NO) {
        NSLog(@"%@", [error description]);
    }
    
    return blog;
}

-(Blog*)blogWithTitle:(NSString*)title
{
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSError *error;
    NSArray *result;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title=%@", title];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Blog"];
    [request setPredicate:predicate];
    [request setFetchLimit:1];
    result = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", [error description]);
    }
    
    return [result firstObject];
}

-(Article*)insertNewArticleWithTitle:articleTitle
{
    NSManagedObjectContext *context = [[NSApp delegate] managedObjectContext];
    NSError *error;
    Article *article;
    
    article = [NSEntityDescription insertNewObjectForEntityForName:@"Article"
                                            inManagedObjectContext:context];
    
    article.title = [articleTitle copy];
    
    if ([context save:&error] == NO) {
        NSLog(@"%@", [error description]);
    }
    
    return article;
}

@end
