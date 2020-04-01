//
//  SHA256HashUtility.swift
//
//  Created by Oliver Paray on 4/18/18.
//

import Foundation
import CommonCrypto

public class Hasher{

    //MARK: - Properties

    //MARK: - Initializers

    public init(){

    }

    //MARK: - Class Methods

    //MARK: - Public Methods

    public func getSHA256(input: NSData) -> String {
        return hexStringFromData(input: digest(input: input))
    }

    //MARK: - Private Methods

    fileprivate func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    fileprivate func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }

}
