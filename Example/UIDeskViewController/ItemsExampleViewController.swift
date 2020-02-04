//
//  ItemsExampleViewController.swift
//  UIDeskViewController_Example
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import UIKit
import UIDeskViewController

class ItemsExampleViewController: UIViewController {

    private let cellHeight: CGFloat = 100
    
    private var users: [SimpleUser] = []
    private var tableViewController: UIItemsDeskViewController<SimpleUser, UserCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let users = (UIApplication.shared.delegate as? AppDelegate)?.users else {
            print("Failed to fetch users from AppDelegate")
            return
        }
        tableViewController = UIItemsDeskViewController<SimpleUser, UserCell>(
            items: users,
            configure: { cell, user in
                cell.configure(
                    firstname: user.firstname,
                    lastname: user.lastname,
                    age: user.age)
        },
            didSelectRow: { user, row in
                print("User \(user) is at row \(row)")
        })
        tableViewController.determineCellHeight = { user, row in
            return self.cellHeight
        }
        embed(tableViewController, containerView: view)
    }
}
