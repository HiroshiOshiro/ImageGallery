//
//  CustomViewBase.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/30.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import UIKit

class CustomViewBase: UIView {
    private var className: String {
        get {
            return String(describing: type(of: self)) // ClassName
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        loadNib()
    }
    
    private func loadNib() {
        guard let view = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as? UIView else {
            return
        }
        
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
