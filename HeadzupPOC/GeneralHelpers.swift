//
//  GeneralHelpers.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/15/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

func getVersion() -> String {
    if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
    return version
    }
    return "no version info"
}
