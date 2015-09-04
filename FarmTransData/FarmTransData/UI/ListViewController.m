//
//  ViewController.m
//  FarmTransData
//
//  Created by Lee, Chia-Pei on 2015/9/4.
//  Copyright (c) 2015年 Lee, Chia-Pei. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *simpleTableIdentifier =  @"SimpleTableItem";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;//NSLineBreakByCharWrapping;
    cell.textLabel.numberOfLines = 3;
    cell.textLabel.text = [tableArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)getDataSet
{
    NSMutableArray *aProductName = [[NSMutableArray alloc]init];
    NSMutableArray *aMarketName = [[NSMutableArray alloc]init];
    //作物名稱 & 市場名稱取交集
    for(NSInteger iIndex=0;iIndex < aAllFarmTransData.count;iIndex++)
    {
        [aProductName addObject:[aAllFarmTransData[iIndex] valueForKey:sProductName]];
        [aMarketName addObject:[aAllFarmTransData[iIndex] valueForKey:sMarketName]];
    }
    setProductName = [[NSMutableSet alloc]initWithArray:aProductName];
    setMarketName = [[NSMutableSet alloc]initWithArray:aMarketName];
}

- (void)showListData:(NSString *)sData
{
    tableArray = [[NSMutableArray alloc]init];
    
    NSString *sChoose = bChoose.titleLabel.text;
    NSString *sItem = sData;//bItem.titleLabel.text;
    
    for(id obj in aAllFarmTransData)
    {
        if([sChoose isEqualToString:sProductName])
        {
            NSString *sObjProductName = [obj valueForKey:sProductName];
            if([sItem isEqualToString:sObjProductName])
            {
                NSString *sTemp = [NSString stringWithFormat:@"%@  %@  %@  %@  %@  %@",
                                   [obj valueForKey:sMarketName],
                                   [obj valueForKey:sHightPrice],
                                   [obj valueForKey:sMiddlePrice],
                                   [obj valueForKey:sLowPrice],
                                   [obj valueForKey:sAvgPrice],
                                   [obj valueForKey:sAmount]];
                //NSLog(@"Name:%@,%@",sItem,sTemp);
                [tableArray addObject:sTemp];
            }
        }
        else if ([sChoose isEqualToString:sMarketName])
        {
            NSString *sObjMarketName = [obj valueForKey:sMarketName];
            if([sItem isEqualToString:sObjMarketName])
            {
                NSString *sTemp = [NSString stringWithFormat:@"%@  %@  %@  %@  %@  %@",
                                   [obj valueForKey:sProductName],
                                   [obj valueForKey:sHightPrice],
                                   [obj valueForKey:sMiddlePrice],
                                   [obj valueForKey:sLowPrice],
                                   [obj valueForKey:sAvgPrice],
                                   [obj valueForKey:sAmount]];
                //NSLog(@"Name:%@,%@",sItem,sTemp);
                [tableArray addObject:sTemp];
            }
        }
    }
    [thisTableView reloadData];
}

-(IBAction)bChoose_Action:(id)sender
{
    NSArray *array = [[NSArray alloc] initWithObjects:sProductName,sMarketName,nil];
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"項目"
                                                      message:@"請選擇"
                                                     delegate:self
                                            cancelButtonTitle:cCancel
                                            otherButtonTitles:nil];
    
    for (NSString *title in array)
    {
        [message addButtonWithTitle:title];
    }
    
    [message show];
    bCheckChoose    = bChoose;
}

-(IBAction)bItem_Action:(id)sender
{
    NSString *sChoose = bChoose.titleLabel.text;
    NSArray *array = [[NSArray alloc]init];
    if([sChoose isEqualToString:sProductName])
    {
        array = [[NSArray alloc]initWithArray:[setProductName allObjects]];
    }
    else
    {
        array = [[NSArray alloc]initWithArray:[setMarketName allObjects]];
    }
    
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"作物"
                                                      message:@"請選擇"
                                                     delegate:self
                                            cancelButtonTitle:cCancel
                                            otherButtonTitles:nil];
    
    for (NSString *title in array)
    {
        [message addButtonWithTitle:title];
    }
    
    [message show];
    bCheckChoose    = bItem;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0)
    {
        if([bCheckChoose isEqual:bChoose])
        {
            [bCheckChoose setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            
            NSString *sChoose = [alertView buttonTitleAtIndex:buttonIndex];
            if([sChoose isEqualToString:sProductName])
            {
                NSArray *array = [[NSArray alloc]initWithArray:[setProductName allObjects]];
                [bItem setTitle:array[0] forState:UIControlStateNormal];
            }
            else
            {
                NSArray *array = [[NSArray alloc]initWithArray:[setMarketName allObjects]];
                [bItem setTitle:array[0] forState:UIControlStateNormal];
            }
        }
        else
        {
            [bCheckChoose setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
            
            [self showListData:[alertView buttonTitleAtIndex:buttonIndex]];
            [thisTableView reloadData];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self getDataSet];
    
    NSString *sChoose = bChoose.titleLabel.text;
    if([sChoose isEqualToString:sProductName])
    {
        NSArray *array = [[NSArray alloc]initWithArray:[setProductName allObjects]];
        [bItem setTitle:array[0] forState:UIControlStateNormal];
    }
    else
    {
        NSArray *array = [[NSArray alloc]initWithArray:[setMarketName allObjects]];
        [bItem setTitle:array[0] forState:UIControlStateNormal];
    }
    
    [self showListData:bItem.titleLabel.text];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
