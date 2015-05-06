//
//  MetaData.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/6/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import Foundation
import CoreData

class MetaData: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var value: String
    @NSManaged var isSecured: NSNumber

}
