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

#import "RVTCar.h"
#import "RVTDriver.h"
#import "RVTEngine.h"

@interface RVTConstructorInjectionTests : NSObject
@end

@implementation RVTConstructorInjectionTests

- (void)test
{
//    id<RVTAnnotation> wheelsAnnotation = [[RVTArgumentAnnotation alloc] initWithName:@"Wheels" selector:@selector(initWithDriver:engine:wheels:) argument:2];
//    id<RVTDefinition> carDefinition = [[RVTClassDefinition alloc] initWithClass:[RVTCar class] initializer:@selector(initWithDriver:engine:wheels:) arguments:@[[RVTDriver class], [RVTEngine class], [NSString class]]];
//    id<RVTBinding> driverBinding = [[RVTClassBinding alloc] initWithInterfaceClass:[RVTEngine class] implementationClass:[RVTV6Engine class]];
//    
//    // argument annotations, used to inject specific values
//    NSArray *annotations = @[wheelsAnnotation];
//    
//    // which implementation classes to construct for interfaces
//    NSArray *bindings = @[driverBinding];
//    
//    // dependency list for classes
//    NSArray *definitions = @[carDefinition];
//    
//    RVTInjector *injector = [[RVTInjector alloc] initWithAnnotations:annotations bindings:bindings definitions:definitions];
//    NSLog(@"Created car %@", [injector getInstanceOf:[Car class]]);
}

@end
