//
//  TimeInterval+Extension.swift
//
//  Created by Oliver Paray on 7/3/18.
//  Copyright © 2018 Oliver Paray. All rights reserved.
//

import Foundation

public extension TimeInterval{

    //MARK: - Properties

    var timeFormat:String?{
        get{
            let formatter = DateComponentsFormatter()
            formatter.zeroFormattingBehavior = .pad
            formatter.allowedUnits = [.minute,.second]

            if self > 3600{
                formatter.allowedUnits.insert(.hour)
            }

            if self == 0{
                return (formatter.allowedUnits.contains(.hour) ? "00:00:00" : "00:00")
            }

            return formatter.string(from: self)
        }
    }

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    //MARK: - Private Methods

}
