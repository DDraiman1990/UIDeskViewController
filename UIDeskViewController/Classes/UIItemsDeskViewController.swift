//
//  UIItemsDeskViewController.swift
//  UIDeskViewController
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import Foundation
import UIKit

public class UIItemsDeskViewController<T, Cell: UIDeskCell>: UIBaseDeskViewController<T, Cell> {
    
    // MARK: - Properties | Data
    
    private var items: [T] = []
    
    // MARK: - Properties | UIBaseDeskViewController
    
    override public var cellCount: Int {
        return items.count
    }
    
    // MARK: - Methods | Lifecycle
    
    public init(items: [T],
         configure: @escaping CellConfiguration,
         didSelectRow: @escaping RowSelected) {
        self.items = items
        super.init(configure: configure, didSelectRow: didSelectRow)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required init(configure: @escaping CellConfiguration, didSelectRow: @escaping RowSelected) {
        super.init(configure: configure, didSelectRow: didSelectRow)
    }
    
    // MARK: - Methods | Setter
    
    func set(items: [T]) {
        self.items = items
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Methods | Reload Data
    
    public override func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Methods | UIBaseDeskViewController
    
    override public func item(at indexPath: IndexPath) -> T? {
        return items[indexPath.row]
    }
}
