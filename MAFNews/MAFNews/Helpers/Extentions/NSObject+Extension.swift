//
//  NSObject+Extension.swift
//  MAFNews
//
//  Created by Yousef Mutawe on 7/9/19.
//  Copyright © 2019 Motawe. All rights reserved.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
