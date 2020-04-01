//
//  Dictionary+Extension.swift
//
//  Created by Oliver Paray on 4/20/18.
//

import Foundation

public extension Dictionary{
    
    //MARK: - Initializers
    
    //MARK: - Properties
    
    var allKeys: Array<Any>{
        return Array(self.keys)
    }
    
    //MARK: - Class Methods
    
    //MARK: - Public Methods
    
    func deepCopy() -> Dictionary{
        var copy = Dictionary()
        for (key,value) in self {
            copy[key] = value
        }
        return copy
    }

    func toQueryString() -> String{
        return String(queryStringFromDictionary: self)
    }
    
    func containsKey(_ key:Key) -> Bool{
        return self.keys.contains(key)
    }
    
    func merged(with dictionary:Dictionary) -> Dictionary{
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
    
    //MARK: - Private Methods
    
    fileprivate mutating func merge(with dictionary:Dictionary){
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
}
