//
//  EncDecTestCase.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/13/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import UIKit
import XCTest
import CryptoSwift
import HeadzupPOC

class EncDecTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetEncryptedData() {
        
        //let iv1 = Cipher.randomIV(AES.blockSize)
        let iv:[UInt8] = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let key:[UInt8] = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        for index in 1...5
        {
            
            //let iv:[UInt8] = iv1
            
            var encryptedString0 = CryptoUtil().getEncryptedData("Headzup123", iv: iv, key: key)
            
            
            var decryptedString0 = CryptoUtil().getDecryptedData(encryptedString0, iv: iv, key: key)
        }
        
        
        //First test case
        //let iv = Cipher.randomIV(AES.blockSize)
        
        
        
        var encryptedString0 = CryptoUtil().getEncryptedData("Test", iv: iv, key: key)
        
        
        var decryptedString0 = CryptoUtil().getDecryptedData(encryptedString0, iv: iv, key: key)
        
        //Second test case
        var encryptedString1 = CryptoUtil().getEncryptedData("Exercise", iv: iv, key: key)
        
        
        var decryptedString1 = CryptoUtil().getDecryptedData(encryptedString1, iv: iv, key: key)
        
        
        //Third test case
        var encryptedString2 = CryptoUtil().getEncryptedData("Experiment", iv: iv, key: key)
        
        
        var decryptedString2 = CryptoUtil().getDecryptedData(encryptedString2, iv: iv, key: key)
        
        //Fourth test case
        var encryptedString3 = CryptoUtil().getEncryptedData("Investigation", iv: iv, key: key)
        
        
        var decryptedString3 = CryptoUtil().getDecryptedData(encryptedString3, iv: iv, key: key) 

        
        //XCTAssertNotNil(dm, "unable to get encryptedData")
        
    }
    
    /*func getString(data:[UInt8])->NSString
    {
        let rawData: UnsafePointer<UInt8> = data
        var myData:NSData = NSData(bytes: rawData, length: data.count)
        let base64String:String = myData.base64EncodedStringWithOptions(nil)
        return base64String
    }*/

}
