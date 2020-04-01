//
//  UIView+Extension.swift
//
//  Created by Oliver Paray on 4/25/18.
//

import CoreImage
import Foundation
import QuartzCore
import UIKit

public enum Direction{
    case LeftToRight
    case RightToLeft
    case TopToBottom
    case BottomToTop
}

public extension UIView{
    
    //MARK: - Initializers
    
    //MARK: - Properties
    
    static var trueCenterAnchor:CGPoint{
        return CGPoint(x: 0.5, y: 0.5)
    }
    
    static var bottomCenterAnchor:CGPoint{
        return CGPoint(x: 0.5, y: 1.0)
    }

    var trueCenterPoint:CGPoint{
        return CGPoint(x: (self.frame.width * 0.5) + self.frame.origin.x, y: (self.frame.height * 0.5) + self.frame.origin.y)
    }
    
    var bottomCenterPoint:CGPoint{
        return CGPoint(x: (self.frame.width * 0.5) + self.frame.origin.x, y: (self.frame.height * 1.0) + self.frame.origin.y)
    }
    
    //MARK: - Class Methods
    
    //MARK: - Public Methods
    
    func removeAllSubViews(){
        for subView in self.subviews{
            subView.removeFromSuperview()
        }
    }
    
    func snapshot() -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        guard let result = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return result
    }
    
    func fall(duration timeSpan:CGFloat,timing name:String,willHide hides:Bool = false){
        //Save initial z position
        let initialZ = self.layer.zPosition
        
        //Offset anchor and center for animation
        self.center = self.bottomCenterPoint
        self.layer.anchorPoint = UIView.bottomCenterAnchor
        self.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)

        //Set initial and final transform values
        let initialTransform = self.layer.transform
        
        var finalTransform = initialTransform
        finalTransform.m34 = 1/(self.bounds.size.height * 2.0)
        finalTransform = CATransform3DRotate(finalTransform, CGFloat(90).toRadians(), 1.0, 0.0, 0.0)
        
        //Apply final transform so that it will be the end value after animating
        self.layer.transform = finalTransform
        
        //Animate using given duration
        let fallAnimation = CABasicAnimation(keyPath: "transform")
        fallAnimation.duration = timeSpan.doubleValue()
        fallAnimation.fromValue = initialTransform
        fallAnimation.toValue = finalTransform
        fallAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: name))
        
        self.layer.add(animation: fallAnimation, forKey: "fall") { (completed) in
            if completed{
                //Hide the view so that the new view is revealed behind it
                self.isHidden = hides
                
                //Reset the anchor point and center to the default
                self.center = self.trueCenterPoint

                //Reset the backing layer to the default identity
                self.layer.transform = CATransform3DIdentity
                
                //Reset the initial z
                self.layer.zPosition = initialZ
            }
        }
    }
    
    func dissolve(intoView target:UIView,
                         withDuration span:CGFloat,
                         andHide hide:Bool,
                         curveOptions:UIView.AnimationOptions,
                         completion:((Bool) -> Void)? = nil){
        var animationOptions:UIView.AnimationOptions = curveOptions.union([.transitionCrossDissolve,.layoutSubviews,.allowAnimatedContent])
        if hide{
            animationOptions.insert(.showHideTransitionViews)
        }
        performUIAnimation(target: target, duration: span, options: animationOptions, completion: completion)
    }
    
    func curl(intoView target:UIView,
                     withDuration span:CGFloat,
                     goingUp up:Bool,
                     andHide hide:Bool,
                     curveOptions:UIView.AnimationOptions,
                     completion:((Bool) -> Void)? = nil){
        var animationOptions:UIView.AnimationOptions = curveOptions.union([.layoutSubviews,.allowAnimatedContent])
        if up{
            animationOptions.insert(.transitionCurlDown)
        } else {
            animationOptions.insert(.transitionCurlUp)
        }
        if hide{
            animationOptions.insert(.showHideTransitionViews)
        }
        performUIAnimation(target: target, duration: span, options: animationOptions, completion: completion)
    }

    func flip(intoView target:UIView,
                     withDuration span:CGFloat,
                     andDirection dir:Direction,
                     andHide hide:Bool,
                     curveOptions:UIView.AnimationOptions,
                     completion:((Bool) -> Void)? = nil){
        var animationOptions:UIView.AnimationOptions = curveOptions.union([.layoutSubviews,.allowAnimatedContent])
        switch dir{
        case .BottomToTop:
            animationOptions.insert(.transitionFlipFromTop)
        case .LeftToRight:
            animationOptions.insert(.transitionFlipFromLeft)
        case .TopToBottom:
            animationOptions.insert(.transitionFlipFromBottom)
        case .RightToLeft:
            animationOptions.insert(.transitionFlipFromRight)
        }
        if hide{
            animationOptions.insert(.showHideTransitionViews)
        }
        performUIAnimation(target: target, duration: span, options: animationOptions, completion: completion)
    }
    
    //MARK: - Private Methods
    fileprivate func performUIAnimation(target:UIView,duration:CGFloat,options:UIView.AnimationOptions,completion:((Bool) -> Void)?=nil){
        UIView.transition(from: self, to: target, duration: duration.doubleValue(), options: options, completion: completion)
    }
}
