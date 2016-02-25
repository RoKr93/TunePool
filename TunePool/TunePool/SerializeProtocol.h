//
//  SerializeProtocol.h
//  TunePool
//
//  Created by Evan Shenkman on 2/21/16.
//  Copyright © 2016 Roshan Krishnan. All rights reserved.
//

//#import <Foundation/Foundation.h>

#ifndef SerializeProtocol_h
#define SerializeProtocol_h

@protocol SerializeProtocol <NSObject>

//@required
@optional
+ (NSDictionary *)serializeObjectToDictionary:(id)pObj;

@end

#endif /* SerializeProtocol_h */
