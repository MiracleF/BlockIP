
//
//  HookTool.m
//  FSTool
//
//  Created by kaix on 16/3/22.
//
//

#import "HookTool.h"
#import <objc/message.h>

#pragma obfuscate on

IMP SwizzleClassSelector(Class clazz, SEL selector, IMP newImplementation)
{
    // Get the original implementation we are replacing
    Class metaClass = objc_getMetaClass(class_getName(clazz));
    Method method = class_getClassMethod(metaClass, selector);
    IMP origImp = method_getImplementation(method);
    if (! origImp) {
        return NULL;
    }
    
    class_replaceMethod(metaClass, selector, newImplementation, method_getTypeEncoding(method));
    return origImp;
}

BOOL class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store)
{
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, original);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        imp = class_replaceMethod(class, original, replacement, type);
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    if (imp && store) { *store = imp; }
    return (imp != NULL);
}

//static BOOL class_swizzleMethodAndStor(Class class, SEL original, IMP replacement, IMPPointer store){
//    return class_swizzleMethodAndStore(class , original, replacement, store);
//}

void classStaticFunctionHookOldclass(Class oldClass ,SEL oldName, Class newClass ,SEL newName)
{
    
    Method ori_Method =  class_getInstanceMethod(oldClass, oldName);
    Method my_Method = class_getInstanceMethod(newClass, newName);
    
    if(class_addMethod(oldClass, oldName, method_getImplementation(my_Method),
                       method_getTypeEncoding(my_Method)))
    {
        
        class_replaceMethod(newClass, newName, method_getImplementation(ori_Method), method_getTypeEncoding(ori_Method));
        
    } else {
        
        method_exchangeImplementations(ori_Method, my_Method);
    }
    
}

id getClassVar(id instance,const char* name) {
    Ivar tvar = nil;
    tvar = class_getInstanceVariable([instance class],name);
    if(tvar != nil) {
        return object_getIvar(instance,tvar);
    }
    return nil;
}

 void setClassVar(id instance,const char* name,id value)
{
    Ivar tvar = nil;
    tvar = class_getInstanceVariable([instance class],name);
    if(tvar != nil) {
        object_setIvar(instance,tvar,value);
    }
}

@implementation HookTool

@end
