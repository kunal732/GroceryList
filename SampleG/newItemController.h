//
//  newItemController.h
//  SampleG
//
//  Created by Kunal Batra on 8/26/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface newItemController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *item;
- (IBAction)addItem:(id)sender;

@end
