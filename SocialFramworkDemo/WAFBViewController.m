//
//  WAFBViewController.m
//  SocialFramworkDemo
//
//  Created by Jayaprada Behera on 13/12/13.
//  Copyright (c) 2013 Webileapps. All rights reserved.
//

#import "WAFBViewController.h"

@interface WAFBViewController ()

@end

@implementation WAFBViewController
@synthesize TapImageLbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)takeImage:(UITapGestureRecognizer *)gesture{
    // Initialize Image Picker Controller
    UIImagePickerController *ip = [[UIImagePickerController alloc] init];
    // Set Delegate
    [ip setDelegate:self];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Set Source Type to Camera
        [ip setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        // Set Source Type to Photo Library
        [ip setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    // Present View Controller
    [self presentViewController:ip animated:YES completion:nil];
    
}
- (void)setupView {
    // Add Gesture Recognizer
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(takeImage:)];
    [self.imageView addGestureRecognizer:tgr];
    // Update View
//    [self updateView];
}
-(void)updateView{
    
    BOOL sharingEnabled = self.image ? YES : NO;
    float sharingAlpha = sharingEnabled ? 1.0 : 0.5;
    self.facebookButton.enabled = sharingEnabled;
    self.facebookButton.alpha = sharingAlpha;
    self.shareButton.enabled = sharingEnabled;
    self.shareButton.alpha = sharingAlpha;
    self.twitterButton.enabled = sharingEnabled;
    self.twitterButton.alpha = sharingAlpha;
    
}
-(void)removeKB:(UITapGestureRecognizer *)gesture{
    [self.captionTextField resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKB:)];
    [self.view addGestureRecognizer:tgr];

    [self.imageView.layer setCornerRadius:1.0f];
    [self.imageView.layer setBorderWidth:1.0f];
    [self.imageView.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.imageView.layer setShadowRadius:3.0f];
    [self.imageView setClipsToBounds:YES ];
    
    [self.facebookButton.layer setCornerRadius:5.0f];
    [self.facebookButton.layer setBorderWidth:1.0f];
    [self.facebookButton.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.facebookButton.layer setShadowRadius:3.0f];
    [self.facebookButton setClipsToBounds:YES ];
    
    [self.shareButton.layer setCornerRadius:5.0f];
    [self.shareButton.layer setBorderWidth:1.0f];
    [self.shareButton.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.shareButton.layer setShadowRadius:3.0f];
    [self.shareButton setClipsToBounds:YES ];
    
    [self.twitterButton.layer setCornerRadius:5.0f];
    [self.twitterButton.layer setBorderWidth:1.0f];
    [self.twitterButton.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.twitterButton.layer setShadowRadius:3.0f];
    [self.twitterButton setClipsToBounds:YES ];
    
    [self setupView];
    // Do any additional setup after loading the view from its nib.
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.TapImageLbl.hidden = YES;
    UIImage *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (originalImage) {
        self.image = originalImage;
        // Update View
//        [self updateView];
    }
    // Dismiss Image Picker Controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // Dismiss Image Picker Controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        // Update Image View
        self.imageView.image = _image;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // Resign First Responder
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)facebook:(id)sender {
    if (self.image == nil) {
        [[[UIAlertView alloc]initWithTitle:@"" message:@"Please add image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        return;
    }else{
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            // Initialize Compose View Controller
            SLComposeViewController *vc = nil;
            vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            // Configure Compose View Controller
            [vc setInitialText:self.captionTextField.text];
            [vc addImage:self.image];
            [vc setCompletionHandler:^(SLComposeViewControllerResult result){
                if (result == SLComposeViewControllerResultDone) {
                    [[[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Your post is successfully Posted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                    
                }else{
                }
            }];
            // Present Compose View Controller
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            NSString *message = @"It seems that we cannot talk to Facebook at the moment or you have not yet added your Facebook account to this device. Go to the Settings application to add your Facebook account to this device.";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}
-(IBAction)twitter:(id)sender{
    if (self.image == nil) {
        [[[UIAlertView alloc]initWithTitle:@"" message:@"Please add image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        return;
    }else{
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            
            SLComposeViewController *twitterVC = nil;
            twitterVC= [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [twitterVC setInitialText:self.captionTextField.text];
            [twitterVC addImage:self.image];
            [twitterVC setCompletionHandler:^(SLComposeViewControllerResult result){
                if (result == SLComposeViewControllerResultDone) {
                    [[[UIAlertView alloc] initWithTitle:@"Congratulations" message:@"Your post is successfully Posted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                    self.twitterButton.enabled = YES;
                    self.twitterButton.userInteractionEnabled = YES;
                }else{
                }
            }];
            // Present Compose View Controller
            [self presentViewController:twitterVC animated:YES completion:nil];
            
        }else {
            NSString *message = @"It seems that we cannot talk to Twitter at the moment or you have not yet added your Twitter account to this device. Go to the Settings application to add your Twitter account to this device.";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}
- (IBAction)share:(id)sender {
    // Activity Items
    UIImage *image = self.image;
    NSString *caption = @"";
    if (self.captionTextField.text.length == 0) {
        caption = @" ";//Null Caption causes crash
    }else{
        caption = self.captionTextField.text;
    }
    NSArray *activityItems = @[image, caption];
    // Initialize Activity View Controller
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    // Present Activity View Controller
    [activityVC setCompletionHandler:^(NSString *activityType, BOOL completed){
        
        NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
        if ([activityType isEqualToString:@"com.apple.UIKit.activity.PostToFacebook"]) {
        //show a custom message for successfull posting on FB
        }else {
        
        }
    }];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    //    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Photos"]];
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=Network"]];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
