//
//  UITextFieldExtension.swift
//  RichFlights 2.0
//
//  Created by Tendaishe Gwini on 5/11/21.
//

import UIKit

extension UITextField {
    
    enum PaddingSide {
        case leading
        case trailing
        case both
    }
    
    /**Add padding to UITextField. Sides are leading, trailing or both*/
    func padding(side: PaddingSide, size: CGFloat) {
        switch side {
        case .leading:
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        case .trailing:
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        case .both:
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.height))
            self.leftView = paddingView
            self.leftViewMode = .always
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    
    
}
