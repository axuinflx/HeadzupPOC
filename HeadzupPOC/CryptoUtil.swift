//
//  CryptoUtil.swift
//  HeadzupPOC
//
//  Created by Abebe Woreta on 5/18/15.
//  Copyright (c) 2015 Inflexxion. All rights reserved.
//

import Foundation

public class CryptoUtil
{
    public init()
    {
        
    }
    public func generateSecurityToken(textToBeEncrypted:String) ->NSString {
        
        //return getEncryptedData(textToBeEncrypted)
        return ""
    }
    
    func isValidSecurityToken(token: NSString) -> Bool {
        return false
    }
    
    
    
    public func getEncryptedData(plainText: String, iv:[UInt8], key:[UInt8])->String
    {
        //1. convert plaintext to byte array
        let plainTextData = [UInt8](plainText.utf8)
        
        
        // 2. encrypt
        
        let encryptedData = AES(key: key, iv: iv, blockMode: .CBC)?.encrypt(plainTextData, padding: PKCS7())
        
        //3. Encoded String
        let nsData:NSData = NSData(bytes: encryptedData!, length: encryptedData!.count)
        let base64EncodedString:NSString = nsData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        println("Encoded String: \(base64EncodedString)")
        
        return base64EncodedString as String
        
    }
    
    
    
    public func getDecryptedData(encryptedString:String, iv:[UInt8], key:[UInt8])->NSString
    {
        
        //1. Decoded String
        let nsData:NSData = NSData(base64EncodedString: encryptedString, options: NSDataBase64DecodingOptions(rawValue:0))!
        
        //2. Convert to Byte Array
        let encryptedData = base64ToByteArray(encryptedString)
        
        // 3. decrypt with the same key and IV
        let decryptedData = AES(key: key, iv: iv, blockMode: .CBC)?.decrypt(encryptedData, padding: PKCS7())
        
        //4. Convert to NSData
        let nsDecryptedData:NSData = NSData(bytes: decryptedData!, length: decryptedData!.count)
        
        //5. Convert to NSString
        let decryptedString = NSString(data: nsDecryptedData, encoding: NSUTF8StringEncoding)
        
        println("Decrypted String: \(decryptedString)")
        
        return decryptedString!
    }
    
    func stringToByteArray(inputString:String) -> [UInt8]
    {
        var bytes:[UInt8] = []
        for code in inputString.utf8
        {
            bytes.append(UInt8(code))
        }
        return bytes
    }
    
    func base64ToByteArray(base64String:String) ->[UInt8]
    {
        let nsData:NSData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions(rawValue: 0))!
        //create array of the required size
        var bytes = [UInt8](count: nsData.length, repeatedValue: 0)
        //fill it with data
        nsData.getBytes(&bytes, length:40)
        return bytes
        
    }

}
