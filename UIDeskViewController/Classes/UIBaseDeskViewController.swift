//
//  UIBaseDeskViewController.swift
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
import UIKit

public class UIBaseDeskViewController<T, Cell: UIDeskCell>: UITableViewController, UIGenericDeskViewController {
    
    // MARK: - Properties | Default Values
    
    private let defaultCellHeight: CGFloat = 56
    
    // MARK: - Typealiases | UIGenericDeskViewController
    
    public typealias ModelType = T
    public typealias CellType = Cell
    
    // MARK: - Properties | UIGenericDeskViewController

    public var configure: (Cell, T) -> Void
    public var didSelectRow: (T, Int) -> Void
    public var determineCellHeight: ((T, Int) -> CGFloat)?
    
    // MARK: - Properties | Should be Overridden by Child

    public var cellCount: Int {
        return 0
    }
    
    // MARK: - Methods | Should be Overridden by Child
    public func item(at: IndexPath) -> T? {
        return nil
    }
    public func reloadData() {}
    
    // MARK: - Methods | Lifecycle
    
    required public init(configure: @escaping CellConfiguration,
                  didSelectRow: @escaping RowSelected) {
        self.configure = configure
        self.didSelectRow = didSelectRow
        super.init(style: .plain)
        if let nibInfo = Cell.nibInfo {
            self.tableView.register(nibInfo, forCellReuseIdentifier: Cell.identifier)
        } else {
            self.tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods | Setters
    
    public func setEmptyCellsSeparators(hidden: Bool) {
        if hidden {
            tableView.tableFooterView = UIView()
        } else {
            tableView.tableFooterView = nil
        }
    }
    
    // MARK: - Methods | UITableView DataSource & Delegate
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = item(at: indexPath) else {
            return defaultCellHeight
        }
        return determineCellHeight?(item, indexPath.row) ?? defaultCellHeight
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell,
        let item = item(at: indexPath) else {
            return UITableViewCell()
        }
        configure(cell, item)
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = item(at: indexPath) else {
            return
        }
        didSelectRow(item, indexPath.row)
    }
    
}
