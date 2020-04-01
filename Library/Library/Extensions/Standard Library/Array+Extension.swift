//
//  Array+Extension.swift
//
//  Created by Oliver Paray on 4/20/18.
//

import Foundation

public extension Array where Element:Equatable{

    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    mutating func remove(object: Element?){
        if let temp = object, let idx = firstIndex(where: { $0 == temp }){
            remove(at: idx)
        }
    }

    mutating func remove(objects: [Element]?){
        guard let temp = objects, temp.count>0 else {
            return
        }

        for itm in temp {
            remove(object: itm)
        }
    }

    //MARK: - Private Methods

}

public extension Array{
    
    //MARK: - Initializers
    
    //MARK: - Properties
    
    var commaDelimitedString:String{
        let result = self.reduce("", { (initial, element) -> String in
            initial + "\(element),"
        })
        return String(result[result.startIndex..<result.index(result.endIndex, offsetBy: -1)])
    }
    
    var concatenatedString:String{
        return self.commaDelimitedString.replacingOccurrences(of: ",", with: "")
    }
    
    //MARK: - Class Methods
    
    //MARK: - Public Methods
    
    func deepCopy() -> Array{
        return self.map({ $0 })
    }
        
    func clamp(_ index:Int) -> Int{
        return index <= 0 ? 0 : count < index ? count : index
    }
    
    mutating func cut(from:Int,to:Int) -> [Element]?{
        let from = clamp(from)
        let to = clamp(to)
        
        guard from < to else {return nil}
        
        let result = [Element](self[from...to])
        
        self.removeSubrange(from...to)
        
        return result
    }
    
    mutating func cut(from:Int) -> [Element]?{
        return cut(from: from, to: count)
    }
    
    mutating func cut(to:Int) -> [Element]?{
        return cut(from: 0, to: to)
    }
    
    //MARK: - Private Methods
    
}
