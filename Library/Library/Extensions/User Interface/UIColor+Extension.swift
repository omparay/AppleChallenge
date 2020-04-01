//
//  Color+Extension.swift
//
//  Created by Oliver Paray on 4/19/18.
//

import Foundation
import UIKit

public extension UIColor{
    
    //MARK: - Initializers
    
    convenience init(rgba: Int) {
        self.init(red: CGFloat((rgba >> 24) & 0xFF)/255.0,
                  green: CGFloat((rgba >> 16) & 0xFF)/255.0,
                  blue: CGFloat((rgba >> 8) & 0xFF)/255.0,
                  alpha: CGFloat(rgba & 0xFF)/255.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: CGFloat((rgb >> 16) & 0xFF)/255.0,
                  green: CGFloat((rgb >> 8) & 0xFF)/255.0,
                  blue: CGFloat(rgb & 0xFF)/255.0,
                  alpha: 1.0)
    }
    
    convenience init?(htmlColor: String) {
        var redValue:UInt32 = 0, greenValue:UInt32 = 0, blueValue:UInt32 = 0, alphaValue:UInt32 = 0
        
        switch htmlColor.count {
        case 8:
            if let r = htmlColor.redComponent(), let g = htmlColor.greenComponent(), let b = htmlColor.blueComponent(), let a = htmlColor.alphaComponent(){
                Scanner(string: r).scanHexInt32(&redValue)
                Scanner(string: g).scanHexInt32(&greenValue)
                Scanner(string: b).scanHexInt32(&blueValue)
                Scanner(string: a).scanHexInt32(&alphaValue)

                self.init(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255, blue: CGFloat(blueValue)/255, alpha: CGFloat(alphaValue)/255)
            } else {
                return nil
            }
        case 6:
            if let r = htmlColor.redComponent(), let g = htmlColor.greenComponent(), let b = htmlColor.blueComponent(){
                Scanner(string: r).scanHexInt32(&redValue)
                Scanner(string: g).scanHexInt32(&greenValue)
                Scanner(string: b).scanHexInt32(&blueValue)
                
                self.init(red: CGFloat(redValue)/255, green: CGFloat(greenValue)/255, blue: CGFloat(blueValue)/255, alpha: 1.0)
            } else {
                return nil
            }
        default:
            return nil
        }
    }
    
    //MARK: - Properties
    
    var rgba:(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat){
        get{
            var r:CGFloat = 0.0, g:CGFloat = 0.0, b:CGFloat = 0.0, a:CGFloat = 0.0
            self.getRed(&r, green: &g, blue: &b, alpha: &a)
            return (r,g,b,a)
        }
    }
    
    var hsba:(hue:CGFloat,saturation:CGFloat,brightness:CGFloat,alpha:CGFloat){
        get{
            var h:CGFloat = 0.0, s:CGFloat = 0.0, b:CGFloat = 0.0, a:CGFloat = 0.0
            self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            return (h,s,b,a)
        }
    }

    var htmlColor:String{
        get{
            let temp = rgba
            return String(format: "%02X%02X%02X", Int(temp.red*255),Int(temp.green*255),Int(temp.blue*255))
        }
    }
    
    var brightness:CGFloat{
        get{
            return UIColor.brightnessOfColor(spec: self)
        }
    }
    
    //MARK: - Class Methods

    

    //MARK: - Public Methods
    
    static func brightnessOfColor(spec: UIColor) -> CGFloat{
        if let components = spec.cgColor.components{
            let result = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114) / 1000)
            return result
        }
        return 0.0
    }
    
    //MARK: - Private Methods
    
}
