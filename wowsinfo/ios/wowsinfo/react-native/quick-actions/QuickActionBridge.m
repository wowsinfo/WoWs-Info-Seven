//
//  QuickActionBridge.m
//  wowsinfo
//
//  Created by Yiheng Quan on 19/7/21.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface QuickActionManager : RCTEventEmitter <RCTBridgeModule>
@end

@implementation QuickActionManager

// Export this module
RCT_EXPORT_MODULE()

RCT_EXTERN_METHOD(quickActionEvent: (NSString *)type)

@end
