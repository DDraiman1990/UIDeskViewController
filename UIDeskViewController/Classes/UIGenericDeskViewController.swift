//
//  UIGenericDeskViewController.swift
//  UIDeskViewController
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import UIKit
import UIKit

public protocol UIGenericDeskViewController: UITableViewController {
    associatedtype ModelType
    associatedtype CellType: UIDeskCell
    
    typealias CellConfiguration = (CellType, ModelType) -> Void
    typealias RowSelected = (ModelType, Int) -> Void
    typealias DetermineCellHeight = (ModelType, Int) -> CGFloat
    
    /// The closure to be called when a new cell dequeues.
    var configure: CellConfiguration { get set }
    
    /// The closure to be called when a cell is selected.
    var didSelectRow: RowSelected { get set }
    
    /// A closure to be called every time the controller wishes to
    /// determine the height of each cell.
    var determineCellHeight: DetermineCellHeight? { get set }
    
    /// How many cells does this controller have.
    var cellCount: Int { get }
    
    /// Create a new DeskViewController with the given params
    /// - Parameters:
    ///   - configure: the closure to be called when a new cell dequeues.
    ///   - didSelectRow: the closure to be called when a cell is
    ///   selected.
    init(configure: @escaping CellConfiguration,
         didSelectRow: @escaping RowSelected)
    
    
    /// Return the item at the given indexPath
    /// - Parameter at: the indexPath corresponding with the item we
    /// want.
    func item(at: IndexPath) -> ModelType?
    
    
    /// Reload the table's data.
    /// - Warning: this method differs from UITableView's reloadData.
    /// If you wish to reload this controller's data, call this method.
    func reloadData()
    
    
    /// Will hide/show separators below the last cell of the table.
    /// - Parameter hidden: should the extra separators be hidden.
    func setEmptyCellsSeparators(hidden: Bool)
}
