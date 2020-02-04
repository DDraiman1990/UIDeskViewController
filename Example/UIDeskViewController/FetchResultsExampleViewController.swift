//
//  FetchResultsExampleViewController.swift
//  UIDeskViewController_Example
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
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
