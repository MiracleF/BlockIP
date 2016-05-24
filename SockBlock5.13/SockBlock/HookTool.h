//
//  HookTool.h
//  FSTool
//
//  Created by kaix on 16/3/22.
//
//

#import <Foundation/Foundation.h>
typedef IMP *IMPPointer;

//class Hello {
//private:
//    id greeting_text; // holds an NSString
//public:
//    Hello() {
//        greeting_text = @"Hello, world!";
//    }
//    Hello(const char* initial_greeting_text) {
//        greeting_text = [[NSString alloc] initWithUTF8String:initial_greeting_text];
//    }
//    void say_hello() {
//        printf("%s/n", [greeting_text UTF8String]);
//    }  
//};


@interface HookTool : NSObject

@end

IMP     SwizzleClassSelector(Class clazz, SEL selector, IMP newImplementation);
BOOL    class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store);
void    classStaticFunctionHookOldclass(Class oldClass ,SEL oldName, Class newClass ,SEL newName);
id      getClassVar(id instance,const char* name);
void    setClassVar(id instance,const char* name,id value);