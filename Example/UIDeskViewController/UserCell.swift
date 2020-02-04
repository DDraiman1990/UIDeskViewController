//
//  UserCell.swift
//  UIDeskViewController_Example
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet private weak var firstnameLabel: UILabel!
    @IBOutlet private weak var lastnameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    func configure(firstname: String,
                   lastname: String,
                   age: Int) {
        firstnameLabel.text = firstname
        lastnameLabel.text = lastname
        ageLabel.text = "\(age)"
    }
}
