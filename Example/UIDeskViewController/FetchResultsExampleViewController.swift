//
//  FetchResultsExampleViewController.swift
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
import CoreData
import UIDeskViewController

class FetchResultsExampleViewController: UIViewController {

    private let cellHeight: CGFloat = 100
    
    private var coreDataStack: CoreDataStack {
        return (UIApplication.shared.delegate as! AppDelegate).coreDataStack
    }
    
    private lazy var fetchedResultsController: NSFetchedResultsController<User> = {
      let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let ageSort = NSSortDescriptor(key: #keyPath(User.age), ascending: true)
        fetchRequest.sortDescriptors = [ageSort]
      let fetchedResultsController = NSFetchedResultsController(
        fetchRequest: fetchRequest,
        managedObjectContext: coreDataStack.managedContext,
        sectionNameKeyPath: nil,
        cacheName: "users")
        
      return fetchedResultsController
    }()
    
    private var tableViewController: UIFetchResultDeskViewController<User, UserCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController = UIFetchResultDeskViewController<User, UserCell>(
            fetchController: fetchedResultsController,
            configure: { cell, user in
                guard let user = user as? User else {
                    return
                }
                cell.configure(
                    firstname: user.firstname ?? "N/A",
                    lastname: user.lastname ?? "N/A",
                    age: Int(user.age))
            },
                didSelectRow: { user, row in
                    print("User \(user) is at row \(row)")
            })
        tableViewController.determineCellHeight = { user, row in
            return self.cellHeight
        }
        tableViewController.setEmptyCellsSeparators(hidden: true)
        embed(tableViewController, containerView: view)
    }
}
