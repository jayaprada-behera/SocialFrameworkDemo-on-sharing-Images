//
//  WAFBViewController.h
//  SocialFramworkDemo
//
//  Created by Jayaprada Behera on 13/12/13.
//  Copyright (c) 2013 Webileapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface WAFBViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *captionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UILabel *TapImageLbl;

@property (strong, nonatomic) UIImage *image;


- (IBAction)facebook:(id)sender;
- (IBAction)share:(id)sender;
-(IBAction)twitter:(id)sender;
@end
