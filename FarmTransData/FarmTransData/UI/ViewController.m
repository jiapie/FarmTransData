//
//  ViewController.m
//  FarmTransData
//
//  Created by Lee, Chia-Pei on 2015/9/4.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *send = segue.destinationViewController;
    [send setValue:aAllFarmTransData forKey:@"aAllFarmTransData"];
}

-(void)HttpProcess:(NSArray *)aAllData
{
    HttpEx *httpex = aAllData[0];
    NSURL *url = aAllData[1];
    
    [httpex HttpPostRequest:url andPostData:nil];
    [httpex HttpPostResponseData];
    [NSThread detachNewThreadSelector: @selector(actIndicatorEnd) toTarget:self withObject:nil];
}

- (void) actIndicatorBegin:(NSString *)sWarningMsg
{
    //NSLog(@"actIndicatorBegin");
    [MessageBox showWaitMessage:thisView and:lwait and:sWarningMsg];
}

-(void) actIndicatorEnd
{
    //NSLog(@"actIndicatorEnd");
    [MessageBox endWaitMessage:thisView and:lwait];
}

-(BOOL)getFarmTransData
{
    //0) Init
    BOOL bSend = YES;
    
    NSString *sUrl = sGetFarmTransDataUrl;
    
    //2) http POST
    if(sUrl)
    {
        HttpEx *httpex = [[HttpEx alloc]init];
        NSURL *url = [HttpEx toURL:sUrl];
        
        [NSThread detachNewThreadSelector: @selector(actIndicatorBegin:) toTarget:self withObject:cDataProcessWait];
        
        if([httpex bCheckConnect:url])
        {
            NSArray *aAllData = [[NSArray alloc]initWithObjects:httpex,url,nil];
            [self performSelectorOnMainThread:@selector(HttpProcess:) withObject:aAllData waitUntilDone:YES];
            
            BOOL bHTTP = httpex.bHttpPostResponse;
            if(bHTTP == NO)
            {
                bSend = NO;
            }
            else
            {
                if(httpex.httpPostBody == nil)
                {//無法取得正確的登入資訊
                    bSend = NO;
                }
                else
                {
                    
                    __autoreleasing NSError* error =nil;
                    aAllFarmTransData = [NSJSONSerialization JSONObjectWithData:httpex.httpPostBody options:NSJSONReadingMutableContainers error: &error];
                    //NSLog(@"data:%@",aAllFarmTransData);
                }
            }
            
        }
        else
        {
            [NSThread detachNewThreadSelector: @selector(actIndicatorEnd) toTarget:self withObject:nil];
            bSend = NO;
        }
    }
    
    return bSend;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([self getFarmTransData])
    {
        [self performSegueWithIdentifier:@"List" sender:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
