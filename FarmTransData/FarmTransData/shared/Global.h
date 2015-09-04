//
//  Global.h
//  shennong-produce
//
//  Created by Lee, Chia-Pei on 2015/4/21.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#ifndef shennong_produce_Global_h
#define shennong_produce_Global_h
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <Mapkit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import "httpEX.h"
#import "jsonEX.h"
#import "MessageBox.h"

//IOS Version
#define UI_IS_IOS8_AND_HIGHER   ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
//UI IPAD,IPHONE
#define UI_IS_IPAD      ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define UI_IS_IPHONE    ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//IPHONE
#define IPHONE4_SCREEN_WIDTH    320
#define UI_IS_IPHONE4   (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define UI_IS_IPHONE5   (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6   (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE6PLUS   (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations

#define UI_SCREEN_H [[UIScreen mainScreen] bounds].size.height
#define UI_SCREEN_W [[UIScreen mainScreen] bounds].size.width

static NSString *cOK        = @"確定";
static NSString *cCancel    = @"取消";
//static NSString *cDataDownloadWait                  = @"資料下載中";
//static NSString *cDataSendWait                      = @"資料傳送中";
//static NSString *cDataReadWait                      = @"資料讀取中";
static NSString *cDataProcessWait                   = @"資料處理中";

static NSString *sGetFarmTransDataUrl = @"http://m.coa.gov.tw/OpenData/FarmTransData.aspx";

static NSString *sTransDate     = @"交易日期";
static NSString *sProductNo     = @"作物代號";
static NSString *sProductName   = @"作物名稱";
static NSString *sMarketNo      = @"市場代號";
static NSString *sMarketName    = @"市場名稱";
static NSString *sHightPrice    = @"上價";
static NSString *sMiddlePrice   = @"中價";
static NSString *sLowPrice      = @"下價";
static NSString *sAvgPrice      = @"平均價";
static NSString *sAmount        = @"交易量";

@interface Global: NSObject
{
    NSMutableDictionary *dGlobal;
}

@property NSMutableDictionary *dGlobal;
-(void)createData;
@end

#endif
