//
//  CAAnimation+Extension.swift
//
//  Created by Oliver Paray on 5/1/18.
//

import Foundation
import QuartzCore

private class AnimationDelegateObject:NSObject,CAAnimationDelegate{

    //MARK: - Properties

    private var startTime:Date?

    private var animationDuration:TimeInterval?

    private var animationTimer:Timer?

    var start:(() -> Void)?

    var completion:((Bool) -> Void)?

    var animating:((CGFloat) -> Void)?{
        willSet{
            if let _ = self.animationTimer{
            } else {
                self.animationTimer = Timer(timeInterval: 0, target: self, selector: #selector(animationIsRunning(timer:)), userInfo: nil, repeats: true)
            }
        }
    }

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    //MARK: - Private Methods

    //MARK: - Delegates
    
    @objc func animationDidStart(_ anim: CAAnimation) {
        guard let startBlock = self.start else { return }
        startBlock()
        if let _ = self.animating{
            self.animationDuration = anim.duration
            self.startTime = Date.now
            if let timer = self.animationTimer{
                RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
            }
        }
    }
    
    @objc func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard let completionBlock = self.completion else { return }
        completionBlock(flag)
        guard let timer = self.animationTimer else { return }
        timer.invalidate()
    }
    
    @objc func animationIsRunning(timer: Timer){
        guard let animatingBlock = self.animating, let animationStart = startTime, let duration = animationDuration else { return }
        let progress = CGFloat(Date.now.timeIntervalSince(animationStart) / duration)
        if progress < 1.0{
            animatingBlock(progress)
        }
    }
}

extension CAAnimation{
    
    //MARK: - Properties

    public var start:(() -> Void)?{
        get{
            guard let delegate = self.delegate as? AnimationDelegateObject else { return nil }
            return delegate.start
        }
        set{
            if let delegate = self.delegate as? AnimationDelegateObject{
                delegate.start = newValue
            } else {
                let delegate = AnimationDelegateObject()
                delegate.start = newValue
                self.delegate = delegate
            }
        }
    }

    public var completion:((Bool) -> Void)?{
        get{
            guard let delegate = self.delegate as? AnimationDelegateObject else { return nil }
            return delegate.completion
        }
        set{
            if let delegate = self.delegate as? AnimationDelegateObject{
                delegate.completion = newValue
            } else {
                let delegate = AnimationDelegateObject()
                delegate.completion = newValue
                self.delegate = delegate
            }
        }
    }

    public var animating:((CGFloat) -> Void)?{
        get{
            guard let delegate = self.delegate as? AnimationDelegateObject else { return nil }
            return delegate.animating
        }
        set{
            if let delegate = self.delegate as? AnimationDelegateObject{
                delegate.animating = newValue
            } else {
                let delegate = AnimationDelegateObject()
                delegate.animating = newValue
                self.delegate = delegate
            }
        }
    }

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    //MARK: - Private Methods
    
    func setStart(_ start:@escaping (() -> Void)){
        self.start = start
    }
    
    func setCompletion(_ completion:@escaping ((Bool) -> Void)){
        self.completion = completion
    }
    
    func setAnimating(_ animating:@escaping ((CGFloat) -> Void)){
        self.animating = animating
    }
}

