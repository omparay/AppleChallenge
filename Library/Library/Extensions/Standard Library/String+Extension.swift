//
//  String+Extension.swift
//
//  Created by Oliver Paray on 4/18/18.
//

import Foundation
import UIKit

public extension String{
    
    //MARK: - Initializers
    
    init(queryStringFromDictionary input: Dictionary<AnyHashable,Any>){
        self.init()
        for (key,value) in input{
            if let key1 = ("\(key)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                let value1 = ("\(value)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed){
                self.append("\(key1)=\(value1)&")
            }
        }
        if self.count > 0{
            self.insert("?", at: self.startIndex)
            self.removeLast(1)
        }
    }

    //MARK: - Properties
    
    static var empty:String{
        return ""
    }
    
    var length: Int{
        get{
            return self.count
        }
    }

    //MARK: - Class Methods

    //MARK: - Public Methods

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    func subString(start: Int) -> String{
        let startIndex = self.index(self.startIndex, offsetBy: start)
        return String(self[startIndex...])
    }
    
    func subString(end: Int) -> String{
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[..<endIndex])
    }
    
    func subString(start: Int, end: Int) -> String{
        let startIndex = self.index(self.startIndex, offsetBy: start-1)
        let endIndex = self.index(self.startIndex, offsetBy: end)
        return String(self[startIndex..<endIndex])
    }
    
    func sha256Hash() -> String{
        if let data = self.data(using: .utf8){
            let util = Hasher()
            return util.getSHA256(input: data as NSData)
        }
        return ""
    }
    
    func toBool() -> Bool?{
        switch self {
        case "TRUE", "True", "true", "YES", "Yes", "yes", "1":
            return true
        case "FALSE", "False", "false", "NO", "No", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func redComponent() -> String?{
        if self.count >= 2{
            return self.subString(end: 2)
        }
        return nil
    }
    
    func greenComponent() -> String?{
        if self.count >= 4{
            return self.subString(start: 3, end: 4)
        }
        return nil
    }

    func blueComponent() -> String?{
        if self.count >= 6{
            return self.subString(start: 5, end: 6)
        }
        return nil
    }

    func alphaComponent() -> String?{
        if self.count >= 8{
            return self.subString(start: 7, end:8)
        }
        return nil
    }

    // MARK: - Private Methods
}
