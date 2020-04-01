//
//  RandomNumberUtility.swift
//
//  Created by Oliver Paray on 4/23/18.
//

import Foundation

public class Random{

    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    public static func double(min: Double? = 0,max: Double) -> Double{
        #if swift(>=4.2)
        return Double.random(in: (min ?? 0)...max)
        #else
        return (min ?? 0) + (drand48() * (max - (min ?? 0)))
        #endif
    }

    public static func float(min: Float? = 0,max: Float) -> Float{
        #if swift(>=4.2)
        return Float.random(in: (min ?? 0)...max)
        #else
        return Float(double(min: Double(min ?? 0), max: Double(max)))
        #endif
    }

    public static func uint(min: UInt? = 0,max:UInt) -> UInt{
        #if swift(>=4.2)
        return UInt.random(in: (min ?? 0)...max)
        #else
        return UInt(UInt32(min ?? 0) + arc4random_uniform(UInt32(max - (min ?? 0))))
        #endif
    }

    public static func int(min: Int? = 0,max: Int) -> Int{
        #if swift(>=4.2)
        return Int.random(in: (min ?? 0)...max)
        #else
        return Int(uint(min: UInt(min ?? 0),max: UInt(max)))
        #endif
    }

    public static func date(days: Int) -> Date{
        let numdays = Random.int(max: days)
        return Date.now.addingDays(days: numdays)
    }

    public static func phone() -> String{
        var result = String.empty
        var number = Array<Int>(repeating: 0, count: 10)

        for i in 0...9{
            number[i] = Random.int(min: 0, max: 9)
        }

        result = String(format: "%d%d%d-%d%d%d-%d%d%d%d",number[0],number[1],number[2],number[3],number[4],number[5],number[6],number[7],number[8],number[9])

        return result
    }

    public static func element<T>(ofArray: Array<T>,fromIndex: Int?=0,toIndex: Int?=0) -> T{
        let minIndex = fromIndex ?? 0
        let maxIndex = toIndex ?? ofArray.count
        let randomIndex = Random.int(min: minIndex, max: maxIndex)
        return ofArray[randomIndex]
    }

    //MARK: - Public Methods

    //MARK: - Private Methods
}
