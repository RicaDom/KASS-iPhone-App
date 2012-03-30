//
//  ViewHelper.h
//  Demo
//
//  Created by Qi He on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Offer.h"
#import "Message.h"
#import "User.h"
#import "ListingTableCell.h"
#import "Constants.h"
#import "KassApp.h"

@interface ViewHelper : NSObject

+ (NSString *)getTitleFromOfferMessage:(User *)user:(Offer *)offer:(Message *)message;

// offers
+ (void) buildOfferAcceptedCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferPendingCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferExpiredCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferPaidCell:(Offer *)item:(ListingTableCell *)cell;
+ (void) buildOfferRejectedCell:(Offer *)item:(ListingTableCell *)cell;

// listItems
+ (void) buildListItemPayNowCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemHasOffersCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemNoOffersCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemExpiredCell:(ListItem *)item:(ListingTableCell *)cell;
+ (void) buildListItemPaidCell:(ListItem *)item:(ListingTableCell *)cell;

+ (void) buildSmallBackButton:(UIButton *)button;
+ (void) buildMapButton:(UIButton *)button;
+ (void) buildBackButton:(UIButton *)button;
+ (void) buildUserInfoButton:(UIButton *)button;
+ (void)buildCancelButton:(UIButton *)button;
+ (void)buildNextButton:(UIButton *)button;
+ (void)buildNextButtonDis:(UIButton *)button;
+ (void) buildAcceptButton:(UIButton *)button;
+ (void)buildEditButton:(UIButton *)button;
+ (void)buildShareButton:(UIButton *)button;
+ (void)buildConfirmButton:(UIButton *)button;
+ (void)buildSendButton:(UIButton *)button;
+ (void)buildLoginButton:(UIButton *)button;
+ (void)buildLogoutButton:(UIButton *)button;
+ (void)buildCheckBoxButton:(UIButton *)button;
+ (void)buildCheckBoxButtonUncheck:(UIButton *)button;
+ (void)buildActivityModifyButton:(UIButton *)button;
+ (void)buildActivityShareButton:(UIButton *)button;
+ (void)buildSmallMapButton:(UIButton *)button;

+ (void)buildProvideAlertButton:(UIButton *)button;
+ (void)buildProvideBrowseButton:(UIButton *)button;
+ (void)buildConfirmPaymentButton:(UIView *)view:(id)delegate;

+ (void)showAlert:(NSString *)title:(NSString *)message:(id)delegate;
+ (void)showErrorAlert:(NSString *)message:(id)delegate;
+ (void)showErrorMessageAlert:(NSDictionary *)errors:(id)delegate;
+ (void) buildMap:(MKMapView *)mapView:(CLLocation *)location;
+ (void)showConnectionErrorAlert:(UIView *)view;
+ (void)showIntroView:(UIView *)view:(UITapGestureRecognizer *)sft:(UITapGestureRecognizer *)cft;
+ (void)hideIntroView:(UIView *)view;

+ (KassApp *)viewKassApp;

+ (UIView *) buildDefaultImageView:(UIView *)diglogView:(NSString *)url;
+ (UIView *) buildDefaultImageViewWithFrame:(UIView *)diglogView:(NSString *)url:(CGRect)frame;

+ (HJManagedImageV *) buildCustomImageView:(UIView *)diglogView:(NSString *)url;
+ (HJManagedImageV *) buildCustomImageViewWithFrame:(UIView *)diglogView:(NSString *)url:(CGRect)frame;
+ (HJManagedImageV *) buildRoundCustomImageViewWithFrame:(UIView *)diglogView:(NSString *)url:(CGRect)frame;

@end
