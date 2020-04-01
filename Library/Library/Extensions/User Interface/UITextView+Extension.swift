//
//  UITextView+Extension.swift
//
//  Created by Mark Kuric on 9/11/18.
//

import UIKit

public extension UITextView {

    var visibleRange: NSRange? {
        guard let start = closestPosition(to: bounds.origin),
            let end = characterRange(at: CGPoint(x: bounds.maxX, y: bounds.maxY - 1.0))?.end
            else { return nil }
        return NSMakeRange(offset(from: beginningOfDocument, to: start), offset(from: start, to: end))
    }
}
