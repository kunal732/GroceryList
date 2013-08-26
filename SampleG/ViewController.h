//
//  ViewController.h
//  SampleG
//
//  Created by Kunal Batra on 8/24/13.
//  Copyright (c) 2013 SendGrid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ViewController : PFQueryTableViewController {
    NSString *List;
    NSDictionary *params;
    NSInteger counter;
    NSInteger refresh;
}
- (IBAction)sendList:(id)sender;


@end
