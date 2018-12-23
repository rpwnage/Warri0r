//
//  ViewController.h
//  Warri0r
//
//  Created by Luca on 22.12.18.
//  Copyright © 2018 Luca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)escape:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *WarriorLog;
- (IBAction)playground:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *playground;

@property (weak, nonatomic) IBOutlet UIButton *escapebutton;

@end

