//
//  Constants.m
//  Demo
//
//  Created by zhicai on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString * const POST_TYPE_TEMPLATE = @"TEMPLATE";
NSString * const POST_TYPE_EDITING = @"EDITING";
NSString * const POST_TEMPLATE_CATEGORY_POPULAR = @"POST_TEMPLATE_CATEGORY_POPULAR";
NSString * const POST_TEMPLATE_CATEGORY_EDITOR = @"POST_TEMPLATE_CATEGORY_EDITOR";
NSString * const POST_TEMPLATE_CATEGORY_CREATIVE = @"POST_TEMPLATE_CATEGORY_CREATIVE";

// Remote notification
NSString * const REMOTE_NOTIFICATION_NEW_MESSAGE = @"new_message";
NSString * const REMOTE_NOTIFICATION_NEW_LISTING = @"new_listing";
NSString * const REMOTE_NOTIFICATION_NEW_ACCEPTED = @"accepted";
NSString * const REMOTE_NOTIFICATION_NEW_OFFER = @"new_offer";

NSString * const UI_BUTTON_LABEL_BACK = @"返回";
NSString * const UI_BUTTON_LABEL_NEXT = @"继续";
NSString * const UI_BUTTON_LABEL_CANCEL = @"取消";
NSString * const UI_BUTTON_LABEL_SUBMIT = @"提交";
NSString * const UI_BUTTON_LABEL_MAP = @"地图";
NSString * const UI_BUTTON_LABEL_SIGIN = @"登陆";
NSString * const UI_BUTTON_LABEL_SIGOUT = @"注销";
NSString * const UI_BUTTON_LABEL_TWITTER_SIGNIN = @"用微博登陆";
NSString * const UI_BUTTON_LABEL_SIGNUP = @"注册";
NSString * const UI_BUTTON_LABEL_SEND = @"发送";
NSString * const UI_BUTTON_LABEL_SHARE = @"分享";

NSString * const UI_BUTTON_LABEL_SIGNIN_TO_POST = @"请登陆后发布";
NSString * const UI_BUTTON_LABEL_POST_NOW = @"发布吧!";
NSString * const UI_BUTTON_LABEL_UPDATE = @"更新";
NSString * const UI_BUTTON_LABEL_DELETE = @"删除";
NSString * const UI_BUTTON_LABEL_RENREN_SHARE = @"发布到人人网";
NSString * const UI_BUTTON_LABEL_WEIBO_SHARE = @"发布到微博";
NSString * const UI_BUTTON_LABEL_SEND_MESSAGE = @"发讯息";
NSString * const UI_BUTTON_LABEL_SEND_EMAIL = @"发邮件";
NSString * const UI_BUTTON_LABEL_SHARE_WITH_FRIEND = @"与好友分享";
NSString * const UI_BUTTON_LABEL_PAY_NOW = @"支付";
NSString * const UI_BUTTON_LABEL_CONFIRM_PAYMENT = @"确认支付";

NSString * const UI_LABEL_NEEDS_REVIEW = @"请查阅";
NSString * const UI_LABEL_OFFER = @"出价";
NSString * const UI_LABEL_EXPIRED = @"过期";
NSString * const UI_LABEL_YOU_OFFERED = @"您的出价";
NSString * const UI_LABEL_BUYER_OFFERED = @"买家出价";
NSString * const UI_LABEL_ACCEPTED = @"交易成功";
NSString * const UI_LABEL_WAITING_FOR_OFFER = @"等待出价";
NSString * const UI_LABEL_OFFER_PENDING = @"等待确认";
NSString * const UI_LABEL_YOU_PAID = @"已付";
NSString * const UI_LABEL_PAID = @"已付";
NSString * const UI_LABEL_REJECTED = @"出价拒绝";
NSString * const UI_LABEL_OFFER_PAID = @"交易已支付";
NSString * const UI_LABEL_OFFER_PAYMENT_CONFIRMED = @"付款已确认";

NSString * const UI_LABEL_ALERT   = @"提醒";
NSString * const UI_LABEL_ERROR   = @"错误";
NSString * const UI_LABEL_DISMISS = @"取消";
NSString * const UI_LABEL_CONFIRM = @"确定";
NSString * const UI_LABEL_VIEW = @"查看";
NSString * const UI_TEXT_VIEW_DESCRIPTION = @"描述一下你想要的服务或东西吧";

NSString * const TEXT_ALL_PRICE   = @"价格无限";
NSString * const TEXT_ALL_GOODS   = @"所有商品";
NSString * const TEXT_IN_PROCESS  = @"处理中...";
NSString * const TEXT_YOUR_LOCATION = @"您现在的位置";
NSString * const TEXT_CUSTOM_LOCATION = @"坐标位置";

NSInteger const VALIDE_USER_NAME_LENGTH_MIN = 3;
NSInteger const VALIDE_USER_NAME_LENGTH_MAX = 118;
NSInteger const VALIDE_USER_PHONE_LENGTH    = 11;

NSString * const ERROR_MSG_CONNECTION_FAILURE = @"网络连接失败";

NSString * const OFFER_STATE_ACCEPTED = @"accepted";
NSString * const OFFER_STATE_REJECTED = @"rejected";
NSString * const OFFER_STATE_PAID = @"paid";
NSString * const OFFER_STATE_IDLE = @"idle";

NSString * const CHANGED_PRICE_NOTIFICATION = @"CHANGED_PRICE_NOTIFICATION";
NSString * const OFFER_TO_PAY_VIEW_NOTIFICATION = @"OFFER_TO_PAY_VIEW_NOTIFICATION";
NSString * const NEW_POST_NOTIFICATION = @"NEW_POST_NOTIFICATION";
NSString * const NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION = @"NO_MESSAGE_TO_MESSAGE_VIEW_NOTIFICATION";

// UI image
NSString * const POPUP_IMAGE_NEW_POST_SUCCESS = @"POPUP_IMAGE_NEW_POST_SUCCESS";
NSString * const POPUP_IMAGE_ACCEPTED_SUCCESS = @"POPUP_IMAGE_ACCEPTED_SUCCESS";

NSString * const UI_IMAGE_TABBAR_IMAGE = @"btn-white-low.png";
NSString * const UI_IMAGE_EMPTY = @"btn-empty.png";
NSString * const UI_IMAGE_NAVIGATION_BACKGROUND = @"panelbg.png";
NSString * const UI_IMAGE_TABBAR_BACKGROUND = @"nav.png";
NSString * const UI_IMAGE_TABBAR_SELECTED_TRANS = @"btn_transwhite.png";
NSString * const UI_IMAGE_LOGIN_BACKGROUND = @"login_bg.png";
NSString * const UI_IMAGE_WEIBO_BUTTON = @"btn_sina_22.png";
NSString * const UI_IMAGE_RENREN_BUTTON = @"btn_renren_22.png";
NSString * const UI_IMAGE_WEIBO_BUTTON_PRESS = @"btn_sina_press.png";
NSString * const UI_IMAGE_RENREN_BUTTON_PRESS = @"btn_renren_press.png";
NSString * const UI_IMAGE_SIGNUP_BUTTON = @"btn_signup_1.png";
NSString * const UI_IMAGE_SIGNUP_BUTTON_PRESS = @"btn_signup_2.png";
NSString * const UI_IMAGE_SIGNUP_BUTTON2 = @"btn_reg_07.png";
NSString * const UI_IMAGE_SIGNUP_BUTTON_PRESS2 = @"btn_reg_14.png";
NSString * const UI_IMAGE_SIGNIN_BUTTON = @"btn_login_1.png";
NSString * const UI_IMAGE_SIGNIN_BUTTON_PRESS = @"btn_login_2.png";
NSString * const UI_IMAGE_LOGIN_SKIP_TEXT = @"skip.gif";
NSString * const UI_IMAGE_LOGIN_BACK_BUTTON = @"btn_back1.png";
NSString * const UI_IMAGE_LOGIN_BACK_BUTTON_PRESS = @"btn_back2.png";
NSString * const UI_IMAGE_LOGIN_BUTTON = @"btn_log1.png";
NSString * const UI_IMAGE_LOGIN_BUTTON_PRESS = @"btn_log2.png";
NSString * const UI_IMAGE_LOGIN_FORGOT_PASS = @"forgetpw.gif";
NSString * const UI_IMAGE_LOGIN_FORM_BACKGROUND = @"log_bg.png";

NSString * const UI_IMAGE_SEND_BUTTON = @"iphone_11.png";
//NSString * const UI_IMAGE_SEND_BUTTON_PRESS = @"iphone_25.png";
NSString * const UI_IMAGE_CONFIRM_BUTTON = @"iphone_09.png";
//NSString * const UI_IMAGE_CONFIRM_BUTTON_PRESS = @"iphone_24.png";
NSString * const UI_IMAGE_EDIT_BUTTON = @"btn-edit.png";
NSString * const UI_IMAGE_EDIT_BUTTON_PRESS = @"btn-edit.png";
NSString * const UI_IMAGE_NEXT_BUTTON_DISABLE = @"next.png";
NSString * const UI_IMAGE_NEXT_BUTTON_ENABLE = @"next.png";
NSString * const UI_IMAGE_NEXT_BUTTON_ENABLE_PRESS = @"next.png";
NSString * const UI_IMAGE_CANCEL_BUTTON = @"iphone_07.png";
NSString * const UI_IMAGE_SHARE_BUTTON = @"btn-rect-share.png";
NSString * const UI_IMAGE_SHARE_BUTTON_PRESS = @"btn-rect-share.png";
NSString * const UI_IMAGE_SMALL_MAP_BUTTON = @"btn_map_small.png";
NSString * const UI_IMAGE_TABLE_CELL_BG = @"listbg.png";
NSString * const UI_IMAGE_TABLE_CELL_BG_PRESS = @"listbg2.png";
NSString * const UI_IMAGE_SMALL_BACK_BUTTON = @"btn-left-arrow-small.png";
NSString * const UI_IMAGE_BACK_BUTTON = @"backarrow_01.png";
NSString * const UI_IMAGE_POST_BUTTON = @"btn-post.png";

NSString * const UI_IMAGE_ACTIVITY_BACKGROUND = @"bg_sky.png";
NSString * const UI_IMAGE_ACTIVITY_EDIT_BUTTON = @"btn-modify.png";
NSString * const UI_IMAGE_ACTIVITY_SHARE_BUTTON = @"btn-share.png";
NSString * const UI_IMAGE_ACTIVITY_PRICE_BG = @"offer_pricebg.png";
NSString * const UI_IMAGE_ACTIVITY_TITLE = @"wodehuodong_shadow.png";
NSString * const UI_IMAGE_ACTIVITY_NOTE_POST = @"note1.png";
NSString * const UI_IMAGE_ACTIVITY_NOTE_BROWSE = @"note2.png";
NSString * const UI_IMAGE_ACTIVITY_ACCEPT_BUTTON = @"accept_1.png";
NSString * const UI_IMAGE_ACTIVITY_ACCEPT_BUTTON_PRESS = @"accept_2.png";

NSString * const UI_IMAGE_BROWSE_POST_BUTTON = @"post_btn.png";
NSString * const UI_IMAGE_BROWSE_POST_SLOGAN = @"post_slogan.png";

NSString * const UI_IMAGE_BROWSE_DATE = @"btn_date.png";
NSString * const UI_IMAGE_BROWSE_DATE_DOWN = @"btn_date_down.png";
NSString * const UI_IMAGE_BROWSE_MAP = @"btn_map.png";
NSString * const UI_IMAGE_BROWSE_MAP_DOWN = @"btn_map_down.png";
NSString * const UI_IMAGE_BROWSE_MONEY = @"btn_money.png";
NSString * const UI_IMAGE_BROWSE_MONEY_DOWN = @"btn_money_down.png";
NSString * const UI_IMAGE_BROWSE_NEAR = @"btn_near.png";
NSString * const UI_IMAGE_BROWSE_NEAR_DOWN = @"btn_near_down.png";
NSString * const UI_IMAGE_BROWSE_SEGMENT_DIVIDER = @"segment_divider.png";

NSString * const UI_IMAGE_SEND_MESSAGE_BACKGROUND = @"iphone_47.png";
NSString * const UI_IMAGE_SEND_MESSAGE_BACKGROUND_EXT = @"buyer-2_03.png";
NSString * const UI_IMAGE_SEND_MESSAGE_PRICE = @"iphone_43.png";
NSString * const UI_IMAGE_SEND_MESSAGE_PRICE_PRESS = @"iphone_41.png";

NSString * const UI_IMAGE_PRICE_BACKGROUND = @"price_bg.png";
NSString * const UI_IMAGE_USER_INFO_BUTTON_DARK = @"iphone_33.png";
NSString * const UI_IMAGE_USER_INFO_BUTTON_GREEN = @"iphone_39.png";

NSString * const UI_IMAGE_POST_SEND_BUTTON = @"btn_big_90.png";
NSString * const UI_IMAGE_POST_SEND_BUTTON_PRESS = @"btn_big_93.png";
NSString * const UI_IMAGE_MESSAGE_DEFAULT_USER = @"avatar-blue.png";
NSString * const UI_IMAGE_MESSAGE_LINE = @"line.png";

NSString * const UI_IMAGE_MESSAGE_DEFAULT_BUYER = @"buyer-blue.png";
NSString * const UI_IMAGE_MESSAGE_DEFAULT_SELLER = @"seller-yellow.png";

NSString * const UI_IMAGE_SETTING_LOGIN = @"btn_03.png";
NSString * const UI_IMAGE_SETTING_LOGIN_PRESS = @"btn_09.png";
NSString * const UI_IMAGE_SETTING_LOGOUT = @"btn_05.png";
NSString * const UI_IMAGE_SETTING_LOGOUT_PRESS = @"btn_10.png";

NSString * const UI_IMAGE_CHECKBOX_CHECK = @"tongbu_check.png";
NSString * const UI_IMAGE_CHECKBOX_UNCHECK = @"tongbu_uncheck.png";

NSString * const UI_IMAGE_PROVIDE = @"pbtn_s.png";
NSString * const UI_IMAGE_PROVIDE_PRESS = @"pbtn_s_down.png";

NSString * const UI_IMAGE_PROVIDE_BROWSE = @"pbtn_s2.png";
NSString * const UI_IMAGE_PROVIDE_BROWSE_PRESS = @"pbtn_s2_down.png";
NSString * const UI_IMAGE_MAP_PIN = @"rmb-pin";
NSString * const UI_IMAGE_DEFAULT_USER = @"everyone";
NSString * const UI_IMAGE_PULLER_LOADING = @"blueArrow.png";
NSString * const UI_IMAGE_PULLER_LOADING_ALPHA = @"blueArrow-alpha.png";

NSString * const UI_IMAGE_WEIBO_BIND_BUTTON_PRESS = @"btn_weibo_77_press.png";
NSString * const UI_IMAGE_WEIBO_BIND_BUTTON = @"btn_weibo_77.png";
NSString * const UI_IMAGE_WEIBO_BIND_BUTTON_CHECK = @"btn_weibo_77_check.png";

NSString * const UI_IMAGE_RENREN_BIND_BUTTON_PRESS = @"btn_renren_77_press.png";
NSString * const UI_IMAGE_RENREN_BIND_BUTTON = @"btn_renren_77.png";
NSString * const UI_IMAGE_RENREN_BIND_BUTTON_CHECK = @"btn_renren_77_check.png";

@end
