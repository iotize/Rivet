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

@interface RVTInitializer ()
@property (strong, nonatomic) Class klass;
@property (assign, nonatomic) SEL selector;
@property (strong, nonatomic) NSArray *providers;
@end

@implementation RVTInitializer

- (id)initWithClass:(Class)klass selector:(SEL)selector providers:(NSArray *)providers
{
    if (self = [self init]) {
        self.klass = klass;
        self.selector = selector;
        self.providers = providers;
    }
    return self;
}

- (id)get
{
    id object = [[self klass] alloc];
    
    NSMutableArray *arguments = [[NSMutableArray alloc] init];
    for (id<RVTProvider> provider in [self providers]) {
        [arguments addObject:[provider get]];
    }
    
    NSMethodSignature *methodSignature = [[self klass] instanceMethodSignatureForSelector:[self selector]];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    [invocation setSelector:[self selector]];
    for (NSUInteger index = 0; index < [arguments count]; index ++) {
        id argument = arguments[index];
        [invocation setArgument:&argument atIndex:index + 2];
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:object];
    
    __unsafe_unretained id initialized;
    [invocation getReturnValue:&initialized];
    
    return initialized;
}

@end
