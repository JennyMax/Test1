//
//  DEVICE.m
//  OneKit
//
//  Created by www.onekit.cn on 15/3/3.
//  Copyright (c) 2015年 www.onekit.cn. All rights reserved.
//

#import "DEVICE.h"
#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/types.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <mach/processor_info.h>
#include <sys/stat.h>
#import "Macro.h"
@implementation DEVICE
+ (void)init
{
    //[OneKit init];
}
+ (NSString *)ID
{
    [self init];
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}
+(NSString *)CPU
{
    [self init];
    return [NSString stringWithFormat:@"%f",[self cpu_usage]];
}
+ (NSString*)Memroy:(BOOL)isAll
{
    [self init];
    if (isAll) {
        return [NSString stringWithFormat:@"%lu",(long)[self totalMemoryBytes]/(1024*1024)];
    }else{
        return [NSString stringWithFormat:@"%lu",(long)[self freeMemoryBytes]/(1024*1024)];
    }
}
+ (NSString*)SD:(BOOL)isAll
{
    [self init];
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    float sdsize;
    if (isAll) {
        sdsize = [[fattributes objectForKey:NSFileSystemSize] floatValue];
    }
    else{
        sdsize = [[fattributes objectForKey:NSFileSystemFreeSize] floatValue];

    }
    return [NSString stringWithFormat:@"%f",sdsize/(1024*1024*1024)];
}
+ (NSString*)NET
{
    [self init];
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    NSString *result;
    switch (type) {
        case 0:
            result = @"无网络连接";
            break;
        case 1:
            result = @"2G";
            break;
        case 2:
            result = @"3G";
            break;
        case 3:
            result = @"4G";
            break;
        case 5:
            result = @"WIFI";
            break;
        default:
            break;
    }
    return result;
}
+ (float)cpu_usage
{
    kern_return_t			kr = { 0 };
    task_info_data_t		tinfo = { 0 };
    mach_msg_type_number_t	task_info_count = TASK_INFO_MAX;
    
    kr = task_info( mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
  //  task_basic_info_t		basic_info = { 0 };
    thread_array_t			thread_list = { 0 };
    mach_msg_type_number_t	thread_count = { 0 };
    
    thread_info_data_t		thinfo = { 0 };
    thread_basic_info_t		basic_info_th = { 0 };
    
    //basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads( mach_task_self(), &thread_list, &thread_count );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    long	tot_sec = 0;
    long	tot_usec = 0;
    float	tot_cpu = 0;
    
    for ( int i = 0; i < thread_count; i++ )
    {
        mach_msg_type_number_t thread_info_count = THREAD_INFO_MAX;
        
        kr = thread_info( thread_list[i], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count );
        if ( KERN_SUCCESS != kr )
            return 0.0f;
        
        basic_info_th = (thread_basic_info_t)thinfo;
        if ( 0 == (basic_info_th->flags & TH_FLAGS_IDLE) )
        {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE;
        }
    }
    
    kr = vm_deallocate( mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t) );
    if ( KERN_SUCCESS != kr )
        return 0.0f;
    
    return tot_cpu;
}
+(NSUInteger) totalMemoryBytes
{
    return [self getSysInfo:HW_PHYSMEM];
}
+ (NSUInteger) getSysInfo: (uint) typeSpecifier
{
    size_t size = sizeof(int);
    int results;
    int mib[2] = {CTL_HW, typeSpecifier};
    sysctl(mib, 2, &results, &size, NULL, 0);
    return (NSUInteger) results;
}
+ (NSUInteger) freeMemoryBytes
{
    mach_port_t           host_port = mach_host_self();
    mach_msg_type_number_t   host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    vm_size_t               pagesize;
    vm_statistics_data_t     vm_stat;
    
    host_page_size(host_port, &pagesize);
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) NSLog(@"Failed to fetch vm statistics");
    
    //    natural_t   mem_used = (vm_stat.active_count + vm_stat.inactive_count + vm_stat.wire_count) * pagesize;
    natural_t   mem_free = vm_stat.free_count * (int)pagesize;
    //    natural_t   mem_total = mem_used + mem_free;
    
    return mem_free;
}
@end
