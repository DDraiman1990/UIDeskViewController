//
//  UIDeskCell.swift
//  UIDeskViewController
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import Foundation
import UIKit

public protocol UIDeskCell: UITableViewCell {
    static var identifier: String { get }
    static var nibInfo: UINib? { get }
}

