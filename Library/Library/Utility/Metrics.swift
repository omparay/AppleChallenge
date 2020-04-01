//
//  Metrics.swift
//
//  Created by Oliver Paray on 5/21/18.
//

import Foundation

public typealias NotificationHandler = (_ notiification:Notification) -> Void
public typealias NotificationTable = [(event:String,object:Any?,handler:NotificationHandler)]

internal typealias Observer = (event:Notification.Name,observer:NSObjectProtocol)
internal typealias ObserverTable = [Observer]

public class Metrics{

    //MARK: - Properties

    public static let sharedInstance = Metrics()

    fileprivate var queue:OperationQueue = OperationQueue()

    internal var observerTable = ObserverTable()

    //MARK: - Initializers

    public convenience init(withQueue queue:DispatchQueue? = DispatchQueue.global(qos: .background),
                            andActionTable table:NotificationTable? = []){
        self.init()
        if let dispatchQueue = queue{
            self.queue = OperationQueue()
            self.queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
            self.queue.underlyingQueue = dispatchQueue
        }
        if let actionTable = table{
            self.addNotificationTable(actionTable)
        }
    }

    deinit {
        for item in observerTable{
            NotificationCenter.default.removeObserver(item.observer)
        }
    }

    //MARK: - Class Methods



    //MARK: - Public Methods

    public func addObserver(forEvent name:NSNotification.Name, sendingObject object:Any? = nil,handler: @escaping NotificationHandler){
        let observer = NotificationCenter.default.addObserver(forName: name, object: object, queue: self.queue, using: handler)
        self.observerTable.append((event: name, observer: observer))
    }

    public func addNotificationTable(_ table:NotificationTable){
        for item in table{
            let notificationName = NSNotification.Name(item.event)
            let observer = NotificationCenter.default.addObserver(forName: notificationName, object: item.object, queue: self.queue, using: item.handler)
            self.observerTable.append((event: notificationName, observer: observer))
        }
    }

    public func removeObserversForEvent(_ name:String){
        self.observerTable = self.observerTable.filter { (event,observer) -> Bool in
            if event.rawValue == name{
                NotificationCenter.default.removeObserver(observer)
                return false
            }
            return true
        }
    }

    public func removeAllObservers(){
        for item in self.observerTable{
            NotificationCenter.default.removeObserver(item.observer)
        }
        self.observerTable.removeAll()
    }

    //MARK: - Private Methods

}
