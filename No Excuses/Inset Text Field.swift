//
//  Inset Text Field.swift
//  No Excuses
//
//  Created by Tony Shum on 2017-04-14.
//  Copyright © 2017 Tony Shum. All rights reserved.
//

import UIKit

class InsetTextField: UITextField {
    
    var inset: CGFloat = 10
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: 0)
    }
    
}
