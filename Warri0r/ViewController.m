//
//  ViewController.m
//  Warri0r
//
//  Created by Luca on 22.12.18.
//  Copyright © 2018 Luca. All rights reserved.
//

#import "ViewController.h"
#include "Exploit.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)lwarrior:(NSString *)logtext {
    NSString *logtext2 = [logtext stringByAppendingString:@"\n"];
    self.WarriorLog.text = [self.WarriorLog.text stringByAppendingFormat:(@"%@", logtext2)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"App opened.");
    _playground.enabled = FALSE;
    self.WarriorLog.layer.cornerRadius = 15;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)pastExploit {
    [self lwarrior:@"Done. Running past exploitation code..."];
    // Any code you want here. Keep in mind that this is only a sandbox escape and you dont have any other system privileges then before. Some debugging code would fit perfectly here.
   

    
    [self lwarrior:@"Post exploitation done."];
    _playground.enabled = TRUE;
    
    
}

- (void)RunCode:(NSString *)Codename{
    NSFileManager *fileMgr;
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Inbox"];
    [fileMgr changeCurrentDirectoryPath:documentsDir];
    NSArray* dirs = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDir
                                                                    error:NULL];
    NSMutableArray *mp3Files = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        if([filename isEqualToString:Codename]){
            NSString *extension = [[filename pathExtension] lowercaseString];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *moddedpath = [documentsDirectory stringByAppendingString:(@"/Inbox/")];
            NSString *moddedpath2 = [moddedpath stringByAppendingString:(@"%@", filename)];
            NSLog(@"Running %@ with extension %@ at path %@",[filename stringByDeletingPathExtension],extension, moddedpath2);
            if ([fileMgr isWritableFileAtPath: moddedpath2]  == YES)
                NSLog (@"File is writable");
            else
                NSLog (@"File is read only");

           // NSLog(@"%@", stringContent);
            NSData *data = [fileMgr contentsAtPath:moddedpath2];
            NSString* datastring = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(datastring);
        }
    }];
}

- (IBAction)escape:(id)sender {
    self.escapebutton.enabled = FALSE;
    [self lwarrior:@"Starting..."];
    NSLog(@"Starting...");
    do_int_overflow();
    [self pastExploit];
}
- (IBAction)playground:(id)sender {
    NSMutableArray *codes=[[NSMutableArray alloc] init];
    UIAlertController *cont = [UIAlertController alertControllerWithTitle:@"How to run code" message:@"To run Objectve C or C code with Warri0r, open a file, for example from textastic, click on share and select warri0r." preferredStyle:UIAlertControllerStyleAlert];
    NSFileManager *fileMgr;
    NSString *entry;
    BOOL isDirectory;
    fileMgr = [NSFileManager defaultManager];
    NSString *documentsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Inbox"];
    [fileMgr changeCurrentDirectoryPath:documentsDir];
    NSDirectoryEnumerator *enumerator = [fileMgr enumeratorAtPath:documentsDir];
    while ((entry = [enumerator nextObject]) != nil)
    {
        if ([fileMgr fileExistsAtPath:entry isDirectory:&isDirectory] && isDirectory)
            NSLog (@"Dismissing directory. - %@", entry);
        if ([entry isEqualToString:@"Root.plist"]){
            NSLog(@"Dismissed basic file.");
        }else{
            NSLog (@"  File - %@", entry);
            UIAlertAction *act = [UIAlertAction actionWithTitle:(@"%@", entry) style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [self RunCode:entry];
            }];
            [cont addAction:act];
            [codes addObject:entry];
        }
    }
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil];
    [cont addAction:act];
    [self presentViewController:cont animated:YES completion:nil];
}
@end
