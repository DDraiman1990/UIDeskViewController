//
//  UIFetchResultDeskViewController.swift
//  UIDeskViewController
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class UIFetchResultDeskViewController<T: NSFetchRequestResult, Cell: UIDeskCell>: UIBaseDeskViewController<T, Cell>, NSFetchedResultsControllerDelegate {
    
    // MARK: - Properties | Data
    
    private var fetchedResultsController: NSFetchedResultsController<T>?
    
    // MARK: - Properties | UIBaseDeskViewController
    
    override public var cellCount: Int {
        guard let sections = fetchedResultsController?.sections else {
            return 0
        }
        let sectionInfo = sections[0]
        return sectionInfo.numberOfObjects
    }
    
    // MARK: - Methods | Lifecycle
    
    public init(fetchController: NSFetchedResultsController<T>?,
         configure: @escaping CellConfiguration,
         didSelectRow: @escaping RowSelected) {
        self.fetchedResultsController = fetchController
        super.init(configure: configure, didSelectRow: didSelectRow)
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required init(configure: @escaping CellConfiguration, didSelectRow: @escaping RowSelected) {
        super.init(configure: configure, didSelectRow: didSelectRow)
    }
    
    // MARK: - Methods | Setter
    
    public func set(fetchController: NSFetchedResultsController<T>) {
        self.fetchedResultsController = fetchController
        self.reloadData()
    }
    
    // MARK: - Methods | Reload Data
    
    public override func reloadData() {
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Failed fetching data with NSFetchedResultsController due to error \(error.localizedDescription)")
        }
    }
    
    // MARK: - Methods | UIBaseDeskViewController
    
    override public func item(at indexPath: IndexPath) -> T? {
        return fetchedResultsController?.object(at: indexPath)
    }
    
    // MARK: - Methods | NSFetchedResultsControllerDelegate
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            break
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            break
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

