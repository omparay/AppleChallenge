//
//  UICollectionView+Extension.swift
//  HumbleFramework
//
//  Created by Oliver Paray on 10/3/18.
//  Copyright © 2018 Oliver Paray. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView{

    //MARK: - Properties

    //MARK: - Initializers

    //MARK: - Class Methods

    //MARK: - Public Methods

    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }

    //MARK: - Private Methods

    fileprivate func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: self.contentOffset.y , width: self.frame.width, height: self.frame.height)
        self.scrollRectToVisible(frame, animated: true)
    }
}
