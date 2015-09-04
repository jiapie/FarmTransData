//
//  ViewController.h
//  FarmTransData
//
//  Created by Lee, Chia-Pei on 2015/9/4.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Global.h"

@interface ListViewController : UIViewController
{
    IBOutlet UITableView    *thisTableView;
    IBOutlet UIButton       *bChoose;
    IBOutlet UIButton       *bItem;
    UIButton                *bCheckChoose;
    NSArray                 *aAllFarmTransData;
    NSMutableArray          *tableArray;
    NSMutableSet            *setProductName;
    NSMutableSet            *setMarketName;    
}

-(IBAction)bChoose_Action:(id)sender;
-(IBAction)bItem_Action:(id)sender;
@end

