//
//  UIView+Extensions.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 24/4/2564 BE.
//

import UIKit

extension UIView {
    func allEqualConstraint(pluginView: UIView) {
        pluginView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        pluginView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        pluginView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        pluginView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
