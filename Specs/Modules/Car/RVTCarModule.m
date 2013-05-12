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

#import "RVTCarModule.h"
#import "RVTCar.h"
#import "RVTEngine.h"
#import "RVTFirefighter.h"
#import "RVTPerson.h"

@interface RVTCarModule ()
@property (strong, nonatomic) id<RVTScope> singletonScope;
@property (strong, nonatomic) id<RVTScope> noScope;
@end

@implementation RVTCarModule

- (id)init
{
    if (self = [super init]) {
        self.singletonScope = [[RVTSingletonScope alloc] initWithCache:[RVTScopeCache new]];
        self.noScope = [[RVTNoScope alloc] init];
    }
    return self;
}

- (NSDictionary *)dependencies
{
    NSMutableDictionary *dependencies = [[NSMutableDictionary alloc] init];
    dependencies[NSStringFromClass([RVTCar class])] = [self car];
    dependencies[NSStringFromClass([RVTEngine class])] = [self engine];
    dependencies[NSStringFromClass([RVTFirefighter class])] = [self firefighter];
    dependencies[NSStringFromClass([RVTPerson class])] = [self driver];
    return dependencies;
}

- (RVTDependency *)car
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithClass:[RVTCar class] selector:@selector(initWithEngine:driver:) dependencies:@[[self engine], [self driver]]];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTCar class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)engine
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithClass:[RVTEngine class] selector:@selector(init) dependencies:nil];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTEngine class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)name
{
    id<RVTProvider> provider = [[RVTValueProvider alloc] initWithValue:@"John Smith"];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self noScope]];
}

- (RVTDependency *)firefighter
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithClass:[RVTFirefighter class] selector:@selector(init) dependencies:nil];
    id<RVTProvider> provider = [[RVTObjectProvider alloc] initWithClass:[RVTFirefighter class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:provider scope:[self singletonScope]];
}

- (RVTDependency *)driver
{
    RVTInitializer *initializer = [[RVTInitializer alloc] initWithClass:[RVTPerson class] selector:@selector(initWithName:occupation:) dependencies:@[[self name], [self firefighter]]];
    RVTObjectProvider *carProvider = [[RVTObjectProvider alloc] initWithClass:[RVTPerson class] initializer:initializer properties:nil];
    return [[RVTDependency alloc] initWithProvider:carProvider scope:[self noScope]];
}

@end