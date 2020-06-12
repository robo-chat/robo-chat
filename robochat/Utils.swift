//
//  Utils.swift
//  robochat
//
//  Created by yangting on 2020/6/12.
//  Copyright © 2020 robochat. All rights reserved.
//

import Foundation

extension String {
    var isValidAccount: Bool {
        let accountRegEx = "^[\\u4E00-\\u9FA5A-Za-z0-9_]{1,8}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", accountRegEx)
        return predicate.evaluate(with:self)
    }
}
