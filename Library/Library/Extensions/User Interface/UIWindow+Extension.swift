//
//  UIViewController+Extension.swift
//  HumbleFramework
//
//  Created by Oliver Paray on 9/11/18.
//  Copyright © 2018 Oliver Paray. All rights reserved.
//

import CoreImage
import Foundation
import QuartzCore
import UIKit

public extension UIWindow{

    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    func activeViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }

    //MARK: - Private Methods

}
