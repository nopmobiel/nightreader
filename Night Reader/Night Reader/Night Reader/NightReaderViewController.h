//
//  ViewController.h
//  FileSharingDemo
//
//  Created by Kashif Jilani on 11/15/12.
//  Copyright (c) 2012 Kashif Jilani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReaderViewController.h"

@interface NightReaderViewController : UIViewController <UIWebViewDelegate,UITabBarDelegate,UITableViewDataSource,ReaderViewControllerDelegate, UITableViewDelegate> {
    
    IBOutlet UITableView *MaintableView;
    NSArray *dataArray;
    NSMutableArray *finalArray;
}

@property (nonatomic, retain) UITableView *MaintableView;

@end
