//
//  Alipay.m
//  kass
//
//  Created by Qi He on 12-3-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Alipay.h"

#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "WBUtil.h"

@implementation Alipay

+ (NSString *)getOfferString:(Offer *)offer:(NSString *)partner:(NSString *)seller
{
  /*
   *生成订单信息及签名
   *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
   */
  //将商品信息赋予AlixPayOrder的成员变量
  AlixPayOrder *order = [[AlixPayOrder alloc] init];
  order.partner = partner;
  order.seller = seller;

  order.tradeNO = offer.alipayTradeNo; //订单ID（由商家自行制定）
  order.productName = offer.title;
  order.productDescription = offer.description;
  order.amount = @"0.01"; //[NSString stringWithFormat:@"%.2f", [offer.price doubleValue]  ]; //商品价格
  order.notifyURL = [[[NSString alloc] initWithFormat:@"%s/v1/alipay/notify", HOST] URLEncodedString]; //回调URL 

  //将商品信息拼接成字符串
  NSString *orderSpec = [order description];

  //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
  id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
  NSString *signedString = [signer signString:orderSpec];

  //将签名成功字符串格式化为订单字符串,请严格按照该格式
  NSString *orderString = nil;
  if (signedString != nil) {
    orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                   orderSpec, signedString, @"RSA"];
  }

  DLog(@"orderString = %@", orderString);
  return orderString;
}

+ (void)payOffer:(Offer *)offer
{
  NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
  NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
  
  //partner和seller获取失败,提示
  if ([partner length] == 0 || [seller length] == 0)
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"缺少partner或者seller。" 
                                                   delegate:self 
                                          cancelButtonTitle:@"确定" 
                                          otherButtonTitles:nil];
    [alert show];
    return;
  }
  
  NSString *orderString = [Alipay getOfferString:offer:partner:seller];
  
  //获取安全支付单例并调用安全支付接口
  AlixPay * alixpay = [AlixPay shared];
  int ret = [alixpay pay:orderString applicationScheme:APP_SCHEME];
  
  if (ret == kSPErrorAlipayClientNotInstalled) {
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
                                                         message:@"您还没有安装支付宝的客户端，请先装。" 
                                                        delegate:self 
                                               cancelButtonTitle:@"确定" 
                                               otherButtonTitles:nil];
    [alertView setTag:123];
    [alertView show];
  }
  else if (ret == kSPErrorSignError) {
    DLog(@"签名错误！");
  }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		NSString * URLString = [NSString stringWithString:@"http://itunes.apple.com/cn/app/id333206289?mt=8"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}

@end
