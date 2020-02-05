//
//  ItemsExampleViewController.swift
//  UIDeskViewController_Example
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio.  
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit
import UIDeskViewController

class ItemsExampleViewController: UIViewController {

    private let cellHeight: CGFloat = 100
    
    private var users: [SimpleUser] = []
    private var tableViewController: UIItemsDeskViewController<SimpleUser, UserCell>!
    private var emptyStateToggleButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let users = (UIApplication.shared.delegate as? AppDelegate)?.users else {
            print("Failed to fetch users from AppDelegate")
            return
        }
        self.users = users
        emptyStateToggleButton = UIBarButtonItem(
            title: "Toggle Empty",
            style: .plain,
            target: self,
            action: #selector(toggleEmptyState))
        self.navigationItem.rightBarButtonItem = emptyStateToggleButton
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
        tableViewController.setEmptyCellsSeparators(hidden: true)
        
        tableViewController.onEmptyStateChanged = { view, visible in
            print("Empty view \(view) is now \(visible ? "visible" : "hidden")")
        }
        tableViewController.setEmptyStateView(
            title: "Lullaby of Woe",
            description: "As the witcher, brave and bold, paid in coin of gold. He'll chop and slice you, cut and dice you, eat you up whole. Eat you whole.",
            icon: UIImage(named: "dvc_wolf"))
        tableViewController.refresh = { completed in
            print("Refreshing")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                print("Finished refreshing!")
                completed()
            })
        }
        embed(tableViewController, containerView: view)
    }
    
    @objc private func toggleEmptyState() {
        if tableViewController.cellCount == 0 {
            tableViewController.set(items: users)
        } else {
            tableViewController.set(items: [])
        }
    }
}
