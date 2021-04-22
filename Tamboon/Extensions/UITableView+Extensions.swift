//
//  UITableView+Extensions.swift
//  Tamboon
//
//  Created by Khwan Siricharoenporn on 23/4/2564 BE.
//

import UIKit

extension UITableView {
    func register<C: UITableViewCell>(cell cellClass: C.Type, from bundle: Bundle? = nil) {
        let identifier = cellClass.string
        let nib = UINib(nibName: identifier, bundle: bundle)
        
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(by cellClass: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: cellClass.string, for: indexPath) as? T
    }
}
