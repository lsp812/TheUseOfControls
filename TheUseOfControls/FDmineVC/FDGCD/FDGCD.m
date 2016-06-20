//
//  FDGCD.m
//  TheUseOfControls
//
//  Created by 大麦 on 16/5/28.
//  Copyright © 2016年 lsp. All rights reserved.
//

#import "FDGCD.h"

@interface FDGCD ()

@end

@implementation FDGCD


/*
 关于线程的
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //async 异步 ［基本都适用异步］
    //sync 同步
    [self start];
}

-(void)start
{
    //参考文献Objective-C 高级编程  IOS与OS X多线程和内存管理
    //    http://blog.csdn.net/jofranks/article/details/21933283
    //    [self kind_one];
    [self kind_two];
}

-(void)kind_one
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //想知性的任务
        NSLog(@"想执行的任务");
    });
    
    @autoreleasepool {
        NSLog(@"1");
    }
}

-(void)kind_two
{
    //   Dispatch Queue存在两种队列1、等待 Serial Dispatch Queue   2、不等待  Concurrent Dispatch Queue
    dispatch_queue_t qq = dispatch_queue_create("dan_qq", DISPATCH_QUEUE_SERIAL);//有序执行的单线程（一个线程）［队列有序执行］[一般对数据库操作都适用此类队列]
    dispatch_async(qq, ^{
        NSLog(@"加入队列的任务1");
    });
    //
    //
    dispatch_queue_t ww = dispatch_queue_create("dan_ww", DISPATCH_QUEUE_CONCURRENT);//无序执行的(多个线程)[多个线程并发执行]
    dispatch_async(ww, ^{
        NSLog(@"加入队列的任务2");
    });
    //
    
}
-(void)kind_three
{
    //    Main Dispatch Queue/Global Dispatch Queue
    //    在主线程中执行的处理追加到Main Dispatch Queue中使用与NSObject的performSelectorOnMainThread实例方法这一执行方法相同。
    //    获取方法：
    //    //Main Dispatch Queue的获取方法
    //    dispatch_queue_t mainDispatchQueue = dispatch_get_main_queue();
    //    //Global Dispatch Queue高优先级的获取方法
    //    dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    //    //Global Dispatch Queue 默认优先级的获取方法
    //    dispatch_queue_t globalDispatchQueueDefault = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //    //Global Dispatch Queue 低优先级的获取方法
    //    dispatch_queue_t globalDispatchQueueLow = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    //    //Global Dispatch Queue 后台优先级的获取方法
    //    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    //    使用
    //默认优先级的Global Dispatch Queue中执行Block
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //可并行执行的处理
        //在Main Dispatch Queue中执行Block
        dispatch_async(dispatch_get_main_queue(), ^{
            //只能在主线程中执行的处理
        });
    });
    //    DISPATCH_QUEUE_PRIORITY_DEFAULT 布尔值是0
}
-(void)kind_four
{
    //    dispatch_set_target_queue
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.example.***", NULL);
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_set_target_queue(mySerialDispatchQueue, globalDispatchQueueBackground);
    
    //    如果你在多个Serial Dispatch Queue中用dispatch_set_target_queue函数指定目标为某一个Serial Dispatch Queue， 那么原先本应并行执行的多个Serial Dispatch Queue，在目标Serial Dispatch Queue上只能同时执行一个处理：
    
    //    在必须将不可并行执行的处理追加到多个Serial Dispatch Queue中时， 如果使用dispatch_set_target_queue函数将目标指定为某一个Serial Dispatch Queue， 就可以防止处理并行执行。
    
}

-(void)kind_five
{
    //    dispatch_after 延迟处理3秒如下：
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"waited at least three seconds.");
    });
}

-(void)kind_six
{
    //    Dispatch Group
    //    监视Dispatch Queue处理执行的结束。
    //    dispatch_group_create（）；
    //    dispatch_group_async();
    //    dispatch_group_notify();
    //    dispatch_group_wait();
}

-(void)kind_seven
{
    //    dispatch_barrier_async会等待追加到Concurrent DIspatch Queue上的并行执行的处理全部结束之后，再将指定的处理追加到该Queue中。然后再由dispatch_barrier_async函数追加的处理执行完毕之后，Concurrent Dispatch Queue才恢复为一般的动作，追加到该Queue的处理又开始并行执行。
}
-(void)kind_eight
{
    //    dispatch_sync
    //    async：非同步，将指定的Block 非同步地追加到指定的Dispatch Queue中， dispatch_async函数不做任何等待，如图：
    //
    //    sync：同步，将指定的Block 同步 追加到指定的Dispatch Queue中， 在追加Block结束之前，dispatch_sync会一直等
    
    //    注意 不能讲任务追加到主线程会死锁。
    //    dispatch_queue_t queue = dispatch_get_main_queue();
    //    dispatch_async(queue, ^{
    //        dispatch_sync(queue, ^{NSLog(@“hello”);});
    //                                     });
    //
    //            此时，Main Dispatch Queue中执行的Block等待Main Dispatch Queue中要执行的Block执行结束。  死锁了。
}
-(void)kind_nine
{
    //    dispatch_apply
    //    他是dispatch_sync函数和Dispatch Group的关联API。此函数按指定的次数将指定的Block追加到指定的Dispatch Queue中，并等待全部处理之行结束。
    //
    //    dispatch_apply(10, queue, ^(size_t index){NSLog(@“dsf");});
    //
    //                                                    如果用在数组中，那么我们就不用编写for循环了。 直接［array count］
    //
    //                                                    由于dispatch_apply函数与dispatch_sync函数相同，会等待处理执行结束，因此推荐在dispatch_async函数中非同步地执行dispatch_apply函数。
}
-(void)kind_ten
{
    //    当追加大量处理到Dispatch Queue时， 在追加处理的过程中，有时希望不执行已追加的处理。  此时，我们需要挂起Dispatch Queue。当可以执行时再恢复。
    //    suspend是挂起。
    //    resume是恢复。
}
-(void)kind_eleven
{
    //    更新数据的时候，会产生数据不一致的情况，有时候应用程序还会异常结束。    虽然使用Serial Dispatch Queue和dispatch_barrier_async函数可避免这类问题，但是有必要进行更加细粒度的排他控制。
    //    Dispatch Semaphore是持有计数的信号。  计数0时，等待。计数1或者大于1时，减去1而不等待。
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    //    参数表示计数的初始值，此时为1 。
    //    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    //    此函数等待Dispatch Semaphore的计数值达到大于或等于1.  当计数大于1或者再等待中计数值大于等于1，对该计数进行减法并从dispatch_semaphore_wait函数返回。
}
-(void)kind_twelve
{
    //    保证应用程序执行中只执行一次指定处理的api。
    //    这里就是单例模式，在生成单例对象时使用。
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //            sharedInstance = [[self alloc] init];
    });
    //    单例
    //    + (AccountManager *)sharedManager
    //    {
    //        static AccountManager *sharedAccountManagerInstance = nil;
    //        static dispatch_once_t predicate;
    //        dispatch_once(&predicate, ^{
    //            sharedAccountManagerInstance = [[self alloc] init];
    //        });
    //        return sharedAccountManagerInstance;
    //    }
    
}
-(void)kind_thirteen
{
    //    一次使用多线程更快地并列读取文件。
    //    通过Dispatch I/O读写文件时，使用Global Dispatch Queue将一个文件按某个大小read/write。
    //    也可以将文件分割为一块一块地进行读取处理，分割读取的数据通过使用Dispatch Data可以更为简单地进行结合和分割 。
    //    dispatch_io_create  生成Dispatch IO， 指定发生错误时用来执行处理的Block，以及执行该Block的Dispatch Queue。
    //    dispatch_io_set_low_water函数 设定一次读取的大小（分割的大小），
    //    dispatch_io_read函数使用Global Dispatch Queue开始并列读取。
}


@end
