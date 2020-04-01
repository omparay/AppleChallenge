//
//  CALayer+Extension.swift
//
//  Created by Oliver Paray on 5/1/18.
//

import Foundation
import QuartzCore
import UIKit

extension CALayer{
    
    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    public func add(animation anim:CAAnimation, forKey key:String, withCompletion completion:@escaping ((Bool) -> Void) = {_ in }){
        anim.completion = completion
        self.add(anim, forKey: key)
    }

    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.mask = mask
    }

    //MARK: - Private Methods

}
