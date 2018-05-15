//
//  ViewController.m
//  FileSharingDemo
//
//  Created by Kashif Jilani on 11/15/12.
//  Copyright (c) 2012 Kashif Jilani. All rights reserved.
//

#import "NightReaderViewController.h"

@interface NightReaderViewController ()

@end

@implementation NightReaderViewController
@synthesize MaintableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [MaintableView
	 setBackgroundColor:[UIColor blackColor]];
    
    [MaintableView setDelegate:self];
	
    UIColor *NightColor=[UIColor colorWithRed:70 green:0 blue:0 alpha:0.8];
    

    
    [MaintableView setSeparatorColor:NightColor];
    
    NSArray *paths =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
   
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSArray *bundleDirectory = [fileManager contentsOfDirectoryAtPath:documentsPath error:nil];
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"self ENDSWITH '.pdf'"];
    dataArray = [bundleDirectory filteredArrayUsingPredicate:filter];
    finalArray = [dataArray copy];
    
    
    
    NSString *valueString = [[finalArray objectAtIndex:0] stringByDeletingPathExtension];
    
    NSLog(@"Finalarray count %d", finalArray.count);
    NSLog (@"Valuestring %@", valueString);
    
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int x=[finalArray count];
    // Return the number of rows in the section.
    NSLog (@"x= %d", x);
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [MaintableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    // Configure the cell...
    UIFont *myFont = [ UIFont fontWithName: @"System" size: 16.0 ];
    cell.textLabel.font  = myFont;
    // Set up the cell...
    
    UIColor *NightColor=[UIColor colorWithRed:70 green:0 blue:0 alpha:0.8];
 
    UIColor *DarkNightColor=[UIColor colorWithRed:70 green:0 blue:0 alpha:0.3];

    
    
                cell.textLabel.highlightedTextColor =DarkNightColor;
    
    cell.textLabel.textColor=NightColor;
//	[[cell textLabel] setText:contentForThisRow];

 NSString *testje=   [[finalArray objectAtIndex:indexPath.row] stringByDeletingPathExtension];

    NSLog (@"Testje %@", testje);

    cell.textLabel.text = testje;
    
    
    
    
    
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{






	UITableViewCell *cell;
	cell = [MaintableView cellForRowAtIndexPath:indexPath];
    
    UIView *bgColorView = [[UIView alloc] init];
    
    UIColor *DarkNightColor=[UIColor colorWithRed:70 green:0 blue:0 alpha:0.3];
    UIColor *NightColor=[UIColor colorWithRed:70 green:0 blue:0 alpha:0.8];
    [bgColorView setBackgroundColor:DarkNightColor];
    [cell setSelectedBackgroundView:bgColorView];
    
    
    cell.textLabel.textColor=NightColor;
    
    NSString *valueString = [[finalArray objectAtIndex:indexPath.row] stringByDeletingPathExtension];
    NSString *file = [[NSBundle mainBundle] pathForResource:valueString ofType:@"pdf"];
    
    
    NSLog (@"Valuestring %@", file);
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //Considering your pdf is stored in documents directory with name as "pdfFileName"
    
    NSString *pdfPath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.pdf",valueString]];
    
    
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:pdfPath password:nil];
    
    ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
    readerViewController.delegate = self;
    
    [self presentViewController:readerViewController animated:YES completion:nil];
    
    
}

- (void)dismissReaderViewController:(ReaderViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
