//
//  RechnerViewController.m
//  Farbverbrauch
//
//  Created by Christian Oder on 20/02/16.
//  Copyright © 2016 M5 Technologies. All rights reserved.
//

#import "RechnerViewController.h"

@interface RechnerViewController ()

@end

@implementation RechnerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *scriptUrl = [NSURL URLWithString:@"https://farbverbrauch.myself5.de/_h5ai_json/online.txt"];
    NSData *online = [NSData dataWithContentsOfURL:scriptUrl];
    if (online){
        [self generateData];
        [self.gewebe setDelegate:self];
        [self.anzDrucke setDelegate:self];
        [self.druckLcm setDelegate:self];
        [self.druckBcm setDelegate:self];
        [self.bedruckgradP setDelegate:self];
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
    
    if (@available(iOS 13.0, *)) {
        self.view.backgroundColor = UIColor.systemBackgroundColor;
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
        self->data = [[NSMutableArray alloc] init];
        //        NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"farbrechner_ios" ofType:@"json"];
        NSData *RechnerURL = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"https://farbverbrauch.myself5.de/_h5ai_json/farbverbrauch.json"]];
        //        NSArray* contents = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath] options:kNilOptions error:&err];
        NSArray* contents = [NSJSONSerialization JSONObjectWithData:RechnerURL options:kNilOptions error:&err];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [contents enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [self->data addObject:[NSDictionary dictionaryWithObjectsAndKeys:[obj objectForKey:@"Gewebe"], @"DisplayText",obj,@"CustomObject", nil]];
            }];
        });
    });
}

#pragma mark MPGTextField Delegate Methods

- (NSArray *)dataForPopoverInTextField:(MPGTextField *)textField
{
    if ([textField isEqual:self.gewebe]) {
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([textField isEqual:self.anzDrucke]){
        self.anzDruckew = atof([newString UTF8String]);
    }
    if ([textField isEqual:self.druckLcm]){
        self.druckLcmw = atof([newString UTF8String]);
    }
    if ([textField isEqual:self.druckBcm]){
        self.druckBcmw = atof([newString UTF8String]);
    }
    if ([textField isEqual:self.bedruckgradP]){
        self.bedruckgradPw = atof([newString UTF8String]);
    }
    [self fillTextFields];
    return YES;
}

- (void)fillTextFields
{
    float fZero = atof(([@"" UTF8String]));
    if (self.gewebew != fZero && self.anzDruckew != fZero && self.druckLcmw != fZero && self.druckBcmw != fZero && self.bedruckgradPw != fZero){
        [self.druckflM setText:[NSString stringWithFormat:@"%.02f", self.anzDruckew * self.druckLcmw * self.druckBcmw / 10000]];
        [self.farbmengeCM3 setText:[NSString stringWithFormat:@"%.02f", self.gewebew * self.anzDruckew  * self.druckLcmw * self.druckBcmw * self.bedruckgradPw / 1000000]];
        [self.farbmengeL setText:[NSString stringWithFormat:@"%.02f", self.gewebew * self.anzDruckew  * self.druckLcmw * self.druckBcmw * self.bedruckgradPw / 1000000000]];
    }else{
        [self.druckflM setText:@""];
        [self.farbmengeCM3 setText:@""];
        [self.farbmengeL setText:@""];
    }
}

- (void)textField:(MPGTextField *)textField didEndEditingWithSelection:(NSDictionary *)result
{
    //Selection from provided data
    self.gewebew = 0;
    if ([textField isEqual:self.gewebe]) {
        
        NSString* formattedNumberw = [NSString stringWithFormat:@"%@",[[result objectForKey:@"CustomObject"] objectForKey:@"Wert"]];
        self.gewebew = atof([formattedNumberw UTF8String]);
    }
    [self fillTextFields];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

@end
