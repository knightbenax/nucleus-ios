//
//  UIScrollView+ScrollToView.swift
//  Nucleus
//
//  Created by Bezaleel Ashefor on 19/12/2017.
//  Copyright © 2017 Ephod. All rights reserved.
//
import UIKit

extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            //let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            //self.scrollRectToVisible(CGRect(x: childStartPoint.x, y: childStartPoint.y, width: 1, height: self.frame.height), animated: true)
            let point = CGPoint(x: 300, y: 0)
            //print("bass")
            self.setContentOffset(point, animated: true)
            //self.scrollRectToVisible(, animated: animated)
        }
    }
    
    func scrollToViewSide(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }
    
    // Bonus: Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    // Bonus: Scroll to bottom
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}
