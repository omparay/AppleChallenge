//
//  Parser.swift
//
//  Created by Oliver Paray on 4/24/18.
//

import Foundation

public typealias JSON = Dictionary<String,Any>

public class Parser{

    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    public static func jsonFrom(url spec:URL) -> JSON?{
        do {
            let jsonData = try Data(contentsOf: spec)
            return jsonFrom(data: jsonData)
        } catch  {
            return nil
        }
    }

    public static func jsonFrom(file spec:String) -> JSON?{
        let spec = URL(fileURLWithPath: spec)
        return jsonFrom(url: spec)
    }

    public static func jsonFrom(data spec:Data) -> JSON?{
        var result:JSON?
        do {
            result = try JSONSerialization.jsonObject(with: spec, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSON
        } catch {
            return nil
        }
        return result
    }

    public static func jsonFrom(string spec:String) -> JSON?{
        guard let jsonData = spec.data(using: .utf8) else {return nil}
        return jsonFrom(data: jsonData)
    }

    //MARK: - Public Methods

    //MARK: - Private Methods

}
