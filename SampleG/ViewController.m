//
//  ViewController.m
//  SampleG
//
//  Created by Kunal Batra on 8/24/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


-  (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithClassName:@"groceryList"];
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"groceryList";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"item";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
        // self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    List = @"<html><body>";
    refresh =0;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Parse

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}

- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
}


// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    counter =[query countObjects];
    NSLog(@"%d",counter);
    
    
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    
    
    return query;
    
}



// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell
    cell.textLabel.text = [object objectForKey:@"item"];
    
    
    
    //Create the list
    if(refresh <counter)
    {
        NSString *br = @"<br>";
        List = [NSString stringWithFormat:@"%@%@%@", List, br, cell.textLabel.text];
        NSLog(@"%@",List);
        refresh ++;
    }
    
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

    
     [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}



- (IBAction)sendList:(id)sender {
    NSDictionary *params = [NSDictionary dictionaryWithObject:List forKey:@"text"];
    //NSLog(@"%@",List);
    [PFCloud callFunctionInBackground:@"emailGrocery" withParameters:params block:^(id object, NSError *error){} ];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Grocery App"
                                                    message:@"Just emailed the Grocery List."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
    
    

    
}
@end
