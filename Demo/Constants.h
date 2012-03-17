//
//  Constants.h
//  Demo
//
//  Created by zhicai on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#define _UIKeyboardFrameEndUserInfoKey (&UIKeyboardFrameEndUserInfoKey != NULL ? UIKeyboardFrameEndUserInfoKey : @"UIKeyboardBoundsUserInfoKey")

#define REQUEST_TIMEOUT 10
#define _ScrollViewContentSizeX 320 

#define MAP_DISTANCE_LAT 3000
#define MAP_DISTANCE_LNG 3000

#define NAVIGATION_BAR_BACKGROUND_COLOR_RED 0.98
#define NAVIGATION_BAR_BACKGROUND_COLOR_GREEN 0.6
#define NAVIGATION_BAR_BACKGROUND_COLOR_BLUE 0.4
#define NAVIGATION_BAR_BACKGROUND_COLOR_ALPHA 1.0

#define LEFT_BAR_BUTTON_CANCEL 0
#define LEFT_BAR_BUTTON_BACK   1

#define RIGHT_BAR_BUTTON_MAP    0
#define RIGHT_BAR_BUTTON_SEND   1
#define RIGHT_BAR_BUTTON_SHARE  2
#define RIGHT_BAR_BUTTON_LOGIN  3
#define RIGHT_BAR_BUTTON_LOGOUT 4

extern NSString * const POST_TYPE_TEMPLATE;
extern NSString * const POST_TYPE_EDITING;
extern NSString * const POST_TEMPLATE_CATEGORY_POPULAR;
extern NSString * const POST_TEMPLATE_CATEGORY_EDITOR;
extern NSString * const POST_TEMPLATE_CATEGORY_CREATIVE;

// UI BUTTON LABEL
extern NSString * const UI_BUTTON_LABEL_BACK;
extern NSString * const UI_BUTTON_LABEL_NEXT;
extern NSString * const UI_BUTTON_LABEL_CANCEL;
extern NSString * const UI_BUTTON_LABEL_SUBMIT;
extern NSString * const UI_BUTTON_LABEL_MAP;
extern NSString * const UI_BUTTON_LABEL_SIGIN;
extern NSString * const UI_BUTTON_LABEL_SIGOUT;
extern NSString * const UI_BUTTON_LABEL_TWITTER_SIGNIN;
extern NSString * const UI_BUTTON_LABEL_SIGNUP;
extern NSString * const UI_BUTTON_LABEL_SEND;
extern NSString * const UI_BUTTON_LABEL_SHARE;

extern NSString * const UI_BUTTON_LABEL_SIGNIN_TO_POST;
extern NSString * const UI_BUTTON_LABEL_POST_NOW;
extern NSString * const UI_BUTTON_LABEL_UPDATE;
extern NSString * const UI_BUTTON_LABEL_DELETE;
extern NSString * const UI_BUTTON_LABEL_WEIBO_SHARE;
extern NSString * const UI_BUTTON_LABEL_SEND_MESSAGE;
extern NSString * const UI_BUTTON_LABEL_SEND_EMAIL;
extern NSString * const UI_BUTTON_LABEL_SHARE_WITH_FRIEND;
extern NSString * const UI_BUTTON_LABEL_PAY_NOW;

extern NSString * const UI_LABEL_NEEDS_REVIEW;
extern NSString * const UI_LABEL_OFFER;
extern NSString * const UI_LABEL_EXPIRED;
extern NSString * const UI_LABEL_YOU_OFFERED;
extern NSString * const UI_LABEL_ACCEPTED;
extern NSString * const UI_LABEL_WAITING_FOR_OFFER;
extern NSString * const UI_LABEL_OFFER_PENDING;
extern NSString * const UI_LABEL_BUYER_OFFERED;

extern NSString * const OFFER_STATE_ACCEPTED;
extern NSString * const OFFER_STATE_REJECTED;
extern NSString * const OFFER_STATE_IDLE;
// NSNotification Center
extern NSString * const CHANGED_PRICE_NOTIFICATION;
extern NSString * const OFFER_TO_PAY_VIEW_NOTIFICATION;
extern NSString * const NEW_POST_NOTIFICATION;
extern NSString * const NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION;

extern NSString * const UI_LABEL_ERROR;
extern NSString * const UI_LABEL_DISMISS;
extern NSString * const UI_LABEL_CONFIRM;
extern NSString * const UI_TEXT_VIEW_DESCRIPTION;

extern NSInteger const VALIDE_USER_NAME_LENGTH_MIN;
extern NSInteger const VALIDE_USER_NAME_LENGTH_MAX;
extern NSInteger const VALIDE_USER_PHONE_LENGTH;

extern NSString * const ERROR_MSG_CONNECTION_FAILURE;

// UI image
extern NSString * const POPUP_IMAGE_NEW_POST_SUCCESS;
extern NSString * const UI_IMAGE_TABBAR_BACKGROUND;
extern NSString * const UI_IMAGE_TABBAR_SELECTED_TRANS;

extern NSString * const UI_IMAGE_LOGIN_BACKGROUND;
extern NSString * const UI_IMAGE_WEIBO_BUTTON;
extern NSString * const UI_IMAGE_WEIBO_BUTTON_PRESS;
extern NSString * const UI_IMAGE_SIGNUP_BUTTON;
extern NSString * const UI_IMAGE_SIGNUP_BUTTON_PRESS;
extern NSString * const UI_IMAGE_SIGNUP_BUTTON2;
extern NSString * const UI_IMAGE_SIGNUP_BUTTON_PRESS2;
extern NSString * const UI_IMAGE_SIGNIN_BUTTON;
extern NSString * const UI_IMAGE_SIGNIN_BUTTON_PRESS;
extern NSString * const UI_IMAGE_LOGIN_SKIP_TEXT;
extern NSString * const UI_IMAGE_LOGIN_BACK_BUTTON;
extern NSString * const UI_IMAGE_LOGIN_BACK_BUTTON_PRESS;
extern NSString * const UI_IMAGE_LOGIN_BUTTON;
extern NSString * const UI_IMAGE_LOGIN_BUTTON_PRESS;
extern NSString * const UI_IMAGE_LOGIN_FORGOT_PASS;
extern NSString * const UI_IMAGE_LOGIN_FORM_BACKGROUND;
extern NSString * const UI_IMAGE_LOGIN_LABEL;
extern NSString * const UI_IMAGE_SIGUP_LABEL;
extern NSString * const UI_IMAGE_MESSAGE_DEFAULT_USER;
extern NSString * const UI_IMAGE_MESSAGE_LINE;

extern NSString * const UI_IMAGE_SEND_BUTTON;
extern NSString * const UI_IMAGE_SEND_BUTTON_PRESS;
extern NSString * const UI_IMAGE_CONFIRM_BUTTON;
extern NSString * const UI_IMAGE_CONFIRM_BUTTON_PRESS;
extern NSString * const UI_IMAGE_EDIT_BUTTON;
extern NSString * const UI_IMAGE_EDIT_BUTTON_PRESS;
extern NSString * const UI_IMAGE_NEXT_BUTTON_DISABLE;
extern NSString * const UI_IMAGE_NEXT_BUTTON_ENABLE;
extern NSString * const UI_IMAGE_NEXT_BUTTON_ENABLE_PRESS;
extern NSString * const UI_IMAGE_CANCEL_BUTTON;
extern NSString * const UI_IMAGE_BACK_BUTTON;
extern NSString * const UI_IMAGE_BACK_BUTTON_PRESS;
extern NSString * const UI_IMAGE_SHARE_BUTTON;
extern NSString * const UI_IMAGE_SHARE_BUTTON_PRESS;
extern NSString * const UI_IMAGE_MAP_BUTTON;
extern NSString * const UI_IMAGE_MAP_BUTTON_PRESS;
extern NSString * const UI_IMAGE_TABLE_CELL_BG;
extern NSString * const UI_IMAGE_TABLE_CELL_BG_PRESS;

extern NSString * const UI_IMAGE_ACTIVITY_BACKGROUND;
extern NSString * const UI_IMAGE_ACTIVITY_EDIT_BUTTON;
extern NSString * const UI_IMAGE_ACTIVITY_EDIT_BUTTON_PRESS;
extern NSString * const UI_IMAGE_ACTIVITY_SHARE_BUTTON;
extern NSString * const UI_IMAGE_ACTIVITY_SHARE_BUTTON_PRESS;
extern NSString * const UI_IMAGE_ACTIVITY_PRICE_BG;
extern NSString * const UI_IMAGE_ACTIVITY_TITLE;
extern NSString * const UI_IMAGE_ACTIVITY_NOTE_POST;
extern NSString * const UI_IMAGE_ACTIVITY_NOTE_BROWSE;
extern NSString * const UI_IMAGE_ACTIVITY_ACCEPT_BUTTON;
extern NSString * const UI_IMAGE_ACTIVITY_ACCEPT_BUTTON_PRESS;

extern NSString * const UI_IMAGE_BROWSE_POST_BUTTON;
extern NSString * const UI_IMAGE_BROWSE_POST_SLOGAN;
extern NSString * const UI_IMAGE_BROWSE_DATE;
extern NSString * const UI_IMAGE_BROWSE_DATE_DOWN;
extern NSString * const UI_IMAGE_BROWSE_MAP;
extern NSString * const UI_IMAGE_BROWSE_MAP_DOWN;
extern NSString * const UI_IMAGE_BROWSE_MONEY;
extern NSString * const UI_IMAGE_BROWSE_MONEY_DOWN;
extern NSString * const UI_IMAGE_BROWSE_NEAR;
extern NSString * const UI_IMAGE_BROWSE_NEAR_DOWN;
extern NSString * const UI_IMAGE_BROWSE_SEGMENT_DIVIDER;

extern NSString * const UI_IMAGE_SEND_MESSAGE_BACKGROUND;
extern NSString * const UI_IMAGE_SEND_MESSAGE_BACKGROUND_EXT;
extern NSString * const UI_IMAGE_SEND_MESSAGE_PRICE;
extern NSString * const UI_IMAGE_SEND_MESSAGE_PRICE_PRESS;

extern NSString * const UI_IMAGE_PRICE_BACKGROUND;
extern NSString * const UI_IMAGE_USER_INFO_BUTTON_DARK;
extern NSString * const UI_IMAGE_USER_INFO_BUTTON_GREEN;

extern NSString * const UI_IMAGE_POST_SEND_BUTTON;
extern NSString * const UI_IMAGE_POST_SEND_BUTTON_PRESS;

extern NSString * const UI_IMAGE_SETTING_LOGIN;
extern NSString * const UI_IMAGE_SETTING_LOGIN_PRESS;
extern NSString * const UI_IMAGE_SETTING_LOGOUT;
extern NSString * const UI_IMAGE_SETTING_LOGOUT_PRESS;

extern NSString * const UI_IMAGE_CHECKBOX_CHECK;
extern NSString * const UI_IMAGE_CHECKBOX_UNCHECK;

extern NSString * const UI_IMAGE_PROVIDE;
extern NSString * const UI_IMAGE_PROVIDE_PRESS;

@end
