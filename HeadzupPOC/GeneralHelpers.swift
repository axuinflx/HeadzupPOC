//
//  GeneralHelpers.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/18/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//



import Foundation

public class GeneralHelpers
{
    public init()
    {
        
    }
    
    public func getVersion() -> String {
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return "no version info"
    }
}
