//
//  UIFetchResultDeskViewController.swift
//  UIDeskViewController
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
        fetchController?.delegate = self
        reloadData()
        self.onDeleteRequested = { [weak self] item, _ in
            return self?.delete(item: item) ?? false
        }
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
        fetchController.delegate = self
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
    
    private func delete(item: T) -> Bool {
        guard let context = fetchedResultsController?.managedObjectContext,
            let item = item as? NSManagedObject else {
            return false
        }
        context.delete(item)
        do {
            try context.save()
            return true
        } catch {
            context.undo()
            return false
        }
    }
    
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

