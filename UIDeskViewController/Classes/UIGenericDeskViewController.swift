//
//  UIGenericDeskViewController.swift
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
