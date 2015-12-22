//
//  Guests+CoreDataProperties.h
//  OpenbuildingRegistration
//
//  Created by apple on 15/12/15.
//  Copyright © 2015年 apple 公司. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Guests.h"

NS_ASSUME_NONNULL_BEGIN

@interface Guests (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString * idd;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *gander;
@property (nullable, nonatomic, retain) NSString *homeId;

@end

NS_ASSUME_NONNULL_END
