//
//  UIBaseDeskViewController.swift
//  UIDeskViewController
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
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
