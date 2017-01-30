//
//  ViewController.m
//  20170130 iPhone Images
//
//  Created by Minhung Ling on 2017-01-30.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property NSArray *phoneURLArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.phoneURLArray = @[ [NSURL URLWithString:@"http://imgur.com/bktnImE.png"],
                            [NSURL URLWithString:@"http://imgur.com/zdwdenZ.png"],
                            [NSURL URLWithString:@"http://imgur.com/CoQ8aNl.png"],
                            [NSURL URLWithString:@"http://imgur.com/2vQtZBb.png"],
                            [NSURL URLWithString:@"http://imgur.com/y9MIaCS.png"]];
    [self setImageRandom];
    NSURL *myURL = [NSURL URLWithString:@"http://imgur.com/2vQtZBb.png"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDownloadTask *dlt = [mySession downloadTaskWithURL:myURL completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            self.iPhoneImageView.image = image;
        }];
        
    }];
    [dlt resume];
    
    }

- (IBAction)setImage:(id)sender {
    [self setImageRandom];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setImageRandom {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDownloadTask *dlt = [mySession downloadTaskWithURL:self.phoneURLArray[arc4random_uniform(5)] completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
        if (error) {
  //          NSLog(@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
            self.iPhoneImageView.image = image;
        }];
        
    }];
    [dlt resume];
    

}
@end
