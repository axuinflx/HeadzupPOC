//
//  MetaData.swift
//  HeadzupPOC
//
//  Created by Allen Xu on 5/6/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation
import CoreData

public class MetaData: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var value: String
    @NSManaged var isSecured: NSNumber

}

public struct MetaDataKeys{
    public static let PhoneNumber = "Phone"
    public static let PIN = "PIN"
    public static let NickName = "NickName"
    public static let LoginStatus = "LoginStatus"
}