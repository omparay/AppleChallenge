//
//  Date+Extension.swift
//
//  Created by Oliver Paray on 4/19/18.
//

import Foundation

public extension NSDate{

    //MARK: - Properties

    var toDate:Date{
        get{
            return self as Date
        }
    }

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    //MARK: - Private Methods

}

public extension Date{
    
    //MARK: - Initializers
    
    //MARK: - Properties

    var toNSDate:NSDate{
        get{
            return self as NSDate
        }
    }

    var year:Int{
        get{
            return Calendar.current.component(.year, from: self)
        }
    }
    
    var month:Int{
        get{
            return Calendar.current.component(.month, from: self)
        }
    }
    
    var day:Int{
        get{
            return Calendar.current.component(.day, from: self)
        }
    }
    
    var hour:Int{
        get{
            let result = Calendar.current.component(.hour, from: self)
            return (result > 12) ? result - 12 : (result == 0) ? 12 : result
        }
    }
    
    var militaryHour:Int{
        get{
            return Calendar.current.component(.hour, from: self)
        }
    }

    var minute:Int{
        get{
            return Calendar.current.component(.minute, from: self)
        }
    }
    
    var second:Int{
        get{
            return Calendar.current.component(.second, from: self)
        }
    }
    
    var weekday:(dayOfWeek:Int,name:String){
        get{
            let index = Calendar.current.component(.weekday, from: self)
            let value = Calendar.current.weekdaySymbols[index-1]
            return(index,value)
        }
    }
    
    var weekOfYear:Int{
        get{
            return Calendar.current.component(.weekOfYear, from: self)
        }
    }
    
    var weekOfMonth:Int{
        get{
            return Calendar.current.component(.weekOfMonth, from: self)
        }
    }
    
    var quarter:Int{
        get{
            return Calendar.current.component(.quarter, from: self)
        }
    }
    
    var epochTimeInMilliseconds:Double{
        get{
            return epochTimeInSeconds * 1000.0
        }
    }
    
    var epochTimeInSeconds:Double{
        get{
            return floor(self.timeIntervalSince1970)
        }
    }
    
    var epochTimeInMinutes:Double{
        get{
            return epochTimeInSeconds / 60.0
        }
    }
    
    var epochTimeInHours:Double{
        get{
            return epochTimeInMinutes / 60.0
        }
    }
    
    static var now:Date{
        get{
            return Date()
        }
    }

    //MARK: - Class Methods
    
    static func from(string input:String, format pattern:String) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = pattern
        guard let result = formatter.date(from: input) else { return nil }
        return result
    }
    
    //MARK: - Public Methods
    
    func toStringUsing(dateStyle: DateFormatter.Style? = .short, timeStyle: DateFormatter.Style? = nil) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        if let dStyle = dateStyle{
            formatter.dateStyle = dStyle
        }
        if let tStyle = timeStyle{
            formatter.timeStyle = tStyle
        }
        return formatter.string(from: self)
    }
    
    func toString(usingFormat format:String = "MM/dd/yyyy", customMeridiem: Bool = false, amToken: String = "", pmToken: String = "") -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if customMeridiem{
            formatter.amSymbol = amToken
            formatter.pmSymbol = pmToken
        }
        return formatter.string(from: self)
    }

    func elapsed(calendarPeriod components:Set<Calendar.Component>, sinceDate:Date) -> DateComponents{
        let gregorian = Calendar(identifier: .gregorian)
        let result = gregorian.dateComponents(components, from: sinceDate, to: self)
        return result
    }

    func addingDays(days: Int) -> Date {
        let numSeconds = TimeInterval(days * 86400)
        return self.addingTimeInterval(numSeconds)
    }

    // MARK: - Private Methods

}
