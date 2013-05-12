// The MIT License
//
// Copyright (c) 2013 Ryan Davies
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "RVTInitializer.h"
#import "RVTDependency.h"

@interface RVTInitializer ()
@property (strong, nonatomic) Class klass;
@property (assign, nonatomic) SEL selector;
@property (strong, nonatomic) NSArray *dependencies;
@end

@implementation RVTInitializer

- (id)initWithClass:(Class)klass selector:(SEL)selector dependencies:(NSArray *)dependencies
{
    if (self = [self init]) {
        self.klass = klass;
        self.selector = selector;
        self.dependencies = dependencies;
    }
    return self;
}

- (id)perform
{
    id object = [[self klass] alloc];
    
    NSMethodSignature *methodSignature = [[self klass] instanceMethodSignatureForSelector:[self selector]];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:[self selector]];
    for (NSUInteger index = 0; index < [[self dependencies] count]; index ++) {
        RVTDependency *dependency = [[self dependencies] objectAtIndex:index];
        id resolvedObject = [dependency resolve];
        [invocation setArgument:&resolvedObject atIndex:index + 2];
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:object];
    
    __unsafe_unretained id initialized;
    [invocation getReturnValue:&initialized];
    
    return initialized;
}

@end
