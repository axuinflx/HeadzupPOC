//
//  ApplicationData.swift
//  HeadzupPOC
//
//  Created by Allen Xu on 5/11/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class AppContext {
    
    public static var userName = ""
    public static var loginStatus = ""
    public static var phoneNumber = ""
    
    public static func list() {
        println("loginStatus = \(loginStatus)")
        println("phone = \(phoneNumber)")
        println("userName = \(userName)")
    }
    
}
