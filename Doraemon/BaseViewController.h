//
//  ViewController.h
//  Doraemon
//
//  Created by liwei wang on 6/7/2016.
//  Copyright © 2016 liwei wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "MBProgressHUD.h"

#import "HttpRequest.h"
#import "JSONKit.h"
#import "DoraemonHttpDelegate.h"
#import "UIViewController+Servie.h"

#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "UIImage+GIF.h"
#import "UIImage+WebP.h"

#import "MyUserDefault.h"
#import "BroadcastUtils.h"
#import "HttpRequestUtils.h"

#import "UIView+SDAutoLayout.h"
#import "MJExtension.h"
#import "BaseModel.h"

@interface BaseViewController : UIViewController<UIGestureRecognizerDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    MBProgressHUD *TOAST;
    
}

//http request
@property(nonatomic, retain)HttpRequest *httpRequest;
- (void)requestFinished:(ASIHTTPRequest *)request tag:(NSString *)tag;
- (void)requestFailed:(ASIHTTPRequest *)request tag:(NSString *)tag;

- (UIImage*) createImageWithColor: (UIColor*) color;
- (void) alignLabelWithTop:(UILabel *)label;
CGFloat getLableTextWidth(UILabel * label,CGFloat textSize);
-(NSString *)getSha256String:(NSString *)srcString;
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
- (NSString *)documentFolderPath;
-(void)pushViewAnimation:(NSString *)orientation;


@end

