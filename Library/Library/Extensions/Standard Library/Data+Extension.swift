//
//  Data+Extension.swift
//
//  Created by Oliver Paray on 4/18/18.
//

import Foundation

public extension Data{
    
    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    func sha256Hash() -> String{
        let util = Hasher()
        return util.getSHA256(input: self as NSData)
    }

    //MARK: - Private Methods

}
