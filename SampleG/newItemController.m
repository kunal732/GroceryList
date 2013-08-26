//
//  newItemController.m
//  SampleG
//
//  Created by Kunal Batra on 8/26/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import "newItemController.h"

@interface newItemController ()

@end

@implementation newItemController
@synthesize item;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [item becomeFirstResponder];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(id)sender {
    //saves user in parse class "users"
    PFObject *grocery = [PFObject objectWithClassName:@"groceryList"];
    [grocery setObject:item.text forKey:@"item"];
    [grocery saveInBackground];
    
  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Grocery App"
                                                    message:@"Item added to list."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    item.text=@"";
   
}
@end
