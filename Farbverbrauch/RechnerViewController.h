//
//  RechnerViewController.h
//  Farbverbrauch
//
//  Created by Christian Oder on 20/02/16.
//  Copyright © 2016 M5 Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPGTextField.h"

@interface RechnerViewController : UIViewController <UITextFieldDelegate, MPGTextFieldDelegate>
{
    NSMutableArray *data;
}

@property (weak, nonatomic) IBOutlet MPGTextField *gewebe;
@property float gewebew;
@property (weak, nonatomic) IBOutlet UITextField *anzDrucke;
@property float anzDruckew;
@property (weak, nonatomic) IBOutlet UITextField *druckLcm;
@property float druckLcmw;
@property (weak, nonatomic) IBOutlet UITextField *druckBcm;
@property float druckBcmw;
@property (weak, nonatomic) IBOutlet UITextField *bedruckgradP;
@property float bedruckgradPw;
@property (weak, nonatomic) IBOutlet UITextField *druckflM;
@property (weak, nonatomic) IBOutlet UITextField *farbmengeCM3;
@property (weak, nonatomic) IBOutlet UITextField *farbmengeL;

@end
