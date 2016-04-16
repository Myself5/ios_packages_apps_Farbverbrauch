//
//  RezepteViewController.h
//  Farbverbrauch
//
//  Created by Christian Oder on 14/02/16.
//  Copyright © 2016 M5 Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGTextField.h"

@interface RezepteViewController : UIViewController <UITextFieldDelegate, MPGTextFieldDelegate>
{
    NSMutableArray *data;
}

@property (weak, nonatomic) IBOutlet MPGTextField *farbname;
@property (weak, nonatomic) IBOutlet UITextField *farbe1;
@property (weak, nonatomic) IBOutlet UITextField *farbe2;
@property (weak, nonatomic) IBOutlet UITextField *farbe3;
@property (weak, nonatomic) IBOutlet UITextField *farbe4;
@property (weak, nonatomic) IBOutlet UITextField *farbe5;
@property (weak, nonatomic) IBOutlet UITextField *menge1;
@property (weak, nonatomic) IBOutlet UITextField *menge2;
@property (weak, nonatomic) IBOutlet UITextField *menge3;
@property (weak, nonatomic) IBOutlet UITextField *menge4;
@property (weak, nonatomic) IBOutlet UITextField *menge5;

@end
