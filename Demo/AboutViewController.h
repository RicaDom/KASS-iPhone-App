//
//  AboutViewController.h
//  kass
//
//  Created by Wesley Wang on 3/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface AboutViewController : UIViewController {
    UITapGestureRecognizer *singleFingerTap;
    UITapGestureRecognizer *closeFingerTap;
}

@property(strong, nonatomic) MPMoviePlayerController *moviePlayer;
@property (strong, nonatomic) NSArray *aboutArray;
@property (strong, nonatomic) IBOutlet UIButton *leftButton;
- (IBAction)leftButtonAction:(id)sender;

@end
