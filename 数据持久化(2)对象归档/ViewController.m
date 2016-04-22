//
//  ViewController.m
//  数据持久化(2)对象归档
//
//  Created by Azuo on 16/1/5.
//  Copyright © 2016年 Azuo. All rights reserved.
//

#import "ViewController.h"
#import "linePesist.h"
#define CodeString  @"CodeString"

@implementation ViewController

-(NSString *)dataFile
{
    NSArray *ar = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *fielpath = [ar objectAtIndex:0];
    return [fielpath stringByAppendingPathComponent:@"data.archive"];  //不用查字典了。。archive表归档
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filepath = [self dataFile];
    NSLog(@"%@",filepath);
    if([[NSFileManager defaultManager]fileExistsAtPath:filepath])
    {
        //创建2个实例
        NSData *data = [[NSData alloc]initWithContentsOfFile:filepath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        //把已归档的对象读取。赋值给linepesist
        linePesist *linepesist =[unarchiver decodeObjectForKey:CodeString];
        [unarchiver finishDecoding];   //完成解档
        
        for(int i = 0;i<4;i++)
        {
            //把解档的数据分别赋值给文本框
            UITextField *textField = self.fourLines[i];
            textField.text = linepesist.array[i]; //记得是.text
        }
    }
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillResignActiveNotification:) name:UIApplicationWillResignActiveNotification object:app];
}

// 应用回到后台，数据归档、写入文件中
-(void)applicationWillResignActiveNotification:(NSNotification*)notfication
{
    linePesist *linepesit = [[linePesist alloc]init];
    linepesit.array = [self.fourLines valueForKey:@"text"];
    //创建2个实例
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    //使用键/值编码对希望包含在归档中的对象进行归档。
    [archiver encodeObject:linepesit forKey:CodeString];
    [archiver finishEncoding];
    
    NSString *pathField = [self dataFile];
    [data writeToFile:pathField atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
