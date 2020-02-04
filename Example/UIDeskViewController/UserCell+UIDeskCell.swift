//
//  UserCell+UIDeskCell.swift
//  UIDeskViewController_Example
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import Foundation
import UIDeskViewController

extension UserCell: UIDeskCell {
    static var identifier: String {
        return "UserCell"
    }
    
    static var nibInfo: UINib? {
        return UINib(nibName: "UserCell", bundle: Bundle.main)
    }
}
