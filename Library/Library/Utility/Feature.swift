//
//  Feature.swift
//
//  Created by Oliver Paray on 6/15/18.
//

import Foundation

public typealias featureList = [String:Bool]

public class Feature{

    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    public static func load(features list:featureList){
        for (key,value) in list{
            UserDefaults.standard.set(value, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }

    public static func load(features list:JSON){
        for (key,value) in list{
            if let state = value as? Bool{
                UserDefaults.standard.set(state, forKey: key)
            }
        }
        UserDefaults.standard.synchronize()
    }

    public static func isEnabled(forItem name:String) -> Bool{
        guard let result = UserDefaults.standard.value(forKey: name) as? Bool else {
            return false
        }

        return result
    }

    //MARK: - Public Methods

    //MARK: - Private Methods

}
