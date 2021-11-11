//
//  ObjC.h
//  CoffeeCalc
//
//  Created by Michael Jones on 11/11/21.
//

#ifndef ObjC_h
#define ObjC_h


#endif /* ObjC_h */


#import <Foundation/Foundation.h>

@interface ObjC : NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
