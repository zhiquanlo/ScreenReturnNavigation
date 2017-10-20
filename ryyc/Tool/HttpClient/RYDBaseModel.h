//
//  RYDBaseModel.h
//  ryyc
//
//  Created by 吴世宇 on 2017/10/18.
//  Copyright © 2017年 ruyidao. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RYDBaseModel : JSONModel

@property (nonatomic,copy) NSString <Optional>* error_code;//0表示无错误，否则为错误
@property (nonatomic,copy) NSString <Optional>* error_type;//0表示无错误，1访问控制错误，2参数错误，3业务类错误，4数据库访问错误
@property (nonatomic,copy) NSString <Optional>* error_msg;

@end
