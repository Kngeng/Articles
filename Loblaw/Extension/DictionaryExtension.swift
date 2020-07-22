//
//  DictionaryExtension.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-21.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import Foundation

extension Dictionary {
    var data: Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
