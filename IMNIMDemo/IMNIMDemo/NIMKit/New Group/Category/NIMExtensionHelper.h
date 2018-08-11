//
//  NIMExtensionHelper.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/11.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (NIMKitExtension)
- (NSDictionary *)nimkit_jsonDict;
@end


@interface NSDictionary (NIMKitExtension)
- (NSString *)nimkit_jsonString;
@end
