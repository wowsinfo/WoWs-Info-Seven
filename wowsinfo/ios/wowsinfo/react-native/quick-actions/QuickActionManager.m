//
//  QuickActionManager.m
//  wowsinfo
//
//  Created by Yiheng Quan on 20/7/21.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(QuickActionManager, NSObject)

RCT_EXTERN_METHOD(addMainAccount: (NSString *)value)
RCT_EXTERN_METHOD(performPendingShortcut)

@end
