//
//  CGFloat+Extension.swift
//
//  Created by Oliver Paray on 5/2/18.
//

import Foundation
import QuartzCore

extension CGFloat{
    
    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    public func toDegrees() -> CGFloat{
        return (self * 180 / CGFloat.pi)
    }

    public func toRadians() -> CGFloat{
        return (self * CGFloat.pi / 180.0)
    }

    public func floatValue() -> Float{
        return Float(self)
    }

    public func doubleValue() -> Double{
        return Double(self)
    }

    //MARK: - Private Methods

}
