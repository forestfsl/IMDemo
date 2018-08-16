//
//  NIMInputEmoticonManager.h
//  IMNIMDemo
//
//  Created by fengsonglin on 2018/8/13.
//  Copyright © 2018年 com.songlin. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NIMInputEmoticon : NSObject

@property (nonatomic, strong) NSString *emoticonID;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *filename;

@end


@interface NIMInputEmoticonLayout:NSObject
@property (nonatomic, assign) NSInteger rows; //行数
@property (nonatomic, assign) NSInteger columes;//列数
@property (nonatomic, assign) NSInteger itemCountInPage; //每页显示几项
@property (nonatomic, assign) CGFloat cellWidth; //每个单元格宽
@property (nonatomic, assign) CGFloat cellHeight;//每个单元格高
@property (nonatomic, assign) CGFloat imageWidth; //显示图片的宽
@property (nonatomic, assign) CGFloat imageHeight; //显示图片的高
@property (nonatomic, assign) BOOL emoji;

- (instancetype)initEmojiLayout:(CGFloat)width;

- (instancetype)initCharletLayout:(CGFloat)width;

@end

@interface NIMInputEmoticonCatalog : NSObject

@property (nonatomic, strong) NIMInputEmoticonLayout *layout;
@property (nonatomic, strong) NSString *catalogID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDictionary *id2Emoticons;
@property (nonatomic, strong) NSDictionary *tag2Emoticons;
@property (nonatomic, strong) NSArray *emoticons;
@property (nonatomic, strong) NSString *icon; //图标
@property (nonatomic, strong) NSString *iconPressed;//小图标按下去效果
@property (nonatomic, assign) NSInteger pagesCount; //分页数
@end

@interface NIMInputEmoticonManager : NSObject

+ (instancetype)sharedManager;

- (NIMInputEmoticonCatalog *)emoticonCatalog:(NSString *)catalogID;
- (NIMInputEmoticon *)emoticonByTag:(NSString *)tag;
- (NIMInputEmoticon *)emoticonByID:(NSString *)emoticonID;

- (NIMInputEmoticon *)emoticonByCatalogID:(NSString *)catalogID
                               emoticonID:(NSString *)emoticonID;

@end
