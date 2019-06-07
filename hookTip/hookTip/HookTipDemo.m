//
//  HookTipDemo.m
//  hookTip
//
//  Created by ch4r0n on 2019/6/4.
//  Copyright © 2019 ch4r0n. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HookTipDemo.h"
#import "substrate.h"
#import "hookTip-Swift.h"

//notice: but use this function will cause all String to be hooked!
static int (*orig_built_in_string)(char *orig, int length) = NULL;
static int hook_built_in_string(char *orig, int length) {
    NSLog(@"Hooked built function");
    return orig_built_in_string(orig, length);
}


static int (*orig_ViewController_testFunction)(void) = NULL;
static int hook_ViewController_testFunction(void) {
    NSLog(@"Hooked test function");
    //return orig_ViewController_testFunction();
    char *hookVar = "testValue";
    return hook_built_in_string(hookVar, (int)strlen(hookVar));
}

static void __attribute__((constructor)) initialize(void) {
    //this is yourself path/to/app
    void* handle=dlopen("/Users/ch4r0n/Library/Developer/Xcode/DerivedData/SwiftTipWindows-ffxyiitmmyswvnchnphkkjlozssl/Build/Products/Debug/SwiftTipWindows.app/Contents/MacOS/SwiftTipWindows",RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
    if (handle) {
        //$SSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC
        //$S15SwiftTipWindows14ViewControllerC15getATestMessageSSyF
        void *symbol = dlsym(handle, "$S15SwiftTipWindows14ViewControllerC15getATestMessageSSyF");
        
        void *symbol_build_string = dlsym(handle,
                                          "$SSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC");
        if (symbol && symbol_build_string) {
            NSLog(@"i find the symbol!!!!!!!!!!!!!!!!!!!!");
            MSHookFunction((void*)symbol,
                               (void*)hook_ViewController_testFunction,
                               (void**)&orig_ViewController_testFunction);
            
            MSHookFunction((void*)symbol_build_string,
                           (void*)hook_built_in_string,
                           (void**)&orig_built_in_string);
            
        }else{
            NSLog(@"can not find the symbol!!!!!!!!!!!!!");
        }
    }
    
//
//    MSHookFunction(MSFindSymbol(NULL, "_$S15SwiftTipWindows14ViewControllerC15getATestMessageSSyF"),
//                   (void*)hook_ViewController_testFunction,
//                   (void**)&orig_ViewController_testFunction);
}
