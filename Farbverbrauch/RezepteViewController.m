//
//  RezepteViewController.m
//  Farbverbrauch
//
//  Created by Christian Oder on 14/02/16.
//  Copyright © 2016 M5 Technologies. All rights reserved.
//

#import "RezepteViewController.h"

@interface RezepteViewController ()

@end

@implementation RezepteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *scriptUrl = [NSURL URLWithString:@"http://farbverbrauch.myself5.de/_h5ai_json/online.txt"];
    NSData *online = [NSData dataWithContentsOfURL:scriptUrl];
    if (online){
        [self generateData];
        [self.farbname setDelegate:self];
    }else{
        NSLog(@"No Internet");
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"No Internet", nil)
                                                                       message:NSLocalizedString(@"No Internet Connection", nil)
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateData
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        //
        NSError* err = nil;
        data = [[NSMutableArray alloc] init];
        
        //        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"rezepte_ios" ofType:@"json"];
        
        NSData *RezepteURL = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://farbverbrauch.myself5.de/_h5ai_json/rezepte.json"]];
        //        NSArray* contents = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        NSArray* contents = [NSJSONSerialization JSONObjectWithData:RezepteURL options:kNilOptions error:&err];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [data addObject:[NSDictionary dictionaryWithObjectsAndKeys:[obj objectForKey:@"Farbnamen"], @"DisplayText",obj,@"CustomObject", nil]];
            }];
        });
    });
}

#pragma mark MPGTextField Delegate Methods

- (NSArray *)dataForPopoverInTextField:(MPGTextField *)textField
{
    if ([textField isEqual:self.farbname]) {
        return data;
    }
    else{
        return nil;
    }
}

- (BOOL)textFieldShouldSelect:(MPGTextField *)textField
{
    return YES;
}

- (void)textField:(MPGTextField *)textField didEndEditingWithSelection:(NSDictionary *)result
{
    //A selection was made - either by the user or by the textfield. Check if its a selection from the data provided or a NEW entry.
    if ([[result objectForKey:@"CustomObject"] isKindOfClass:[NSString class]] && [[result objectForKey:@"CustomObject"] isEqualToString:@"NEW"]) {
        //New Entry
    }else{
        //Selection from provided data
        if ([textField isEqual:self.farbname]) {
            [self.farbe1 setText:[[result objectForKey:@"CustomObject"] objectForKey:@"Farbe_1"]];
            [self.farbe2 setText:[[result objectForKey:@"CustomObject"] objectForKey:@"Farbe_2"]];
            [self.farbe3 setText:[[result objectForKey:@"CustomObject"] objectForKey:@"Farbe_3"]];
            [self.farbe4 setText:[[result objectForKey:@"CustomObject"] objectForKey:@"Farbe_4"]];
            [self.farbe5 setText:[[result objectForKey:@"CustomObject"] objectForKey:@"Farbe_5"]];
            float fZero = atof(([@"" UTF8String]));
            float fMenge1 = fZero;
            float fMenge2 = fZero;
            float fMenge3 = fZero;
            float fMenge4 = fZero;
            float fMenge5 = fZero;
            NSString* sNumberMenge1 = [NSString stringWithFormat:@"%@",[[result objectForKey:@"CustomObject"] objectForKey:@"Menge_1"]];
            NSString* sNumberMenge2 = [NSString stringWithFormat:@"%@",[[result objectForKey:@"CustomObject"] objectForKey:@"Menge_2"]];
            NSString* sNumberMenge3 = [NSString stringWithFormat:@"%@",[[result objectForKey:@"CustomObject"] objectForKey:@"Menge_3"]];
            NSString* sNumberMenge4 = [NSString stringWithFormat:@"%@",[[result objectForKey:@"CustomObject"] objectForKey:@"Menge_4"]];
            NSString* sNumberMenge5 = [NSString stringWithFormat:@"%@",[[result objectForKey:@"CustomObject"] objectForKey:@"Menge_5"]];
            
            fMenge1 = atof([sNumberMenge1 UTF8String]);
            fMenge2 = atof([sNumberMenge2 UTF8String]);
            fMenge3 = atof([sNumberMenge3 UTF8String]);
            fMenge4 = atof([sNumberMenge4 UTF8String]);
            fMenge5 = atof([sNumberMenge5 UTF8String]);
            
            if (fMenge1 != fZero) {
                [self.menge1 setText:[NSString stringWithFormat:@"%.02f", fMenge1]];
            }else{
                [self.menge1 setText:@""];
            }
            if (fMenge2 != fZero) {
                [self.menge2 setText:[NSString stringWithFormat:@"%.02f", fMenge2]];
            }else{
                [self.menge2 setText:@""];
            }
            if (fMenge3 != fZero) {
                [self.menge3 setText:[NSString stringWithFormat:@"%.02f", fMenge3]];
            }else{
                [self.menge3 setText:@""];
            }
            if (fMenge4 != fZero) {
                [self.menge4 setText:[NSString stringWithFormat:@"%.02f", fMenge4]];
            }else{
                [self.menge4 setText:@""];
            }
            if (fMenge5 != fZero) {
                [self.menge5 setText:[NSString stringWithFormat:@"%.02f", fMenge5]];
            }else{
                [self.menge5 setText:@""];
            }
        }
    }
}

@end
