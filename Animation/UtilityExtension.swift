//
//  UtilityExtension.swift
//  Animation
//
//  Created by yaoxinpan on 2018/1/26.
//  Copyright © 2018年 yaoxp. All rights reserved.
//

import UIKit

extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
