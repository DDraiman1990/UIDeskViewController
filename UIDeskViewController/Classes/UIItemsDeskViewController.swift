//
//  UIItemsDeskViewController.swift
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
        self.onDeleteRequested = { [weak self] _, indexPath, completed in
            self?.delete(itemAt: indexPath)
            completed(true)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    required init(configure: @escaping CellConfiguration, didSelectRow: @escaping RowSelected) {
        super.init(configure: configure, didSelectRow: didSelectRow)
    }
    
    // MARK: - Methods | Setter
    
    public func set(items: [T]) {
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
    
    private func delete(itemAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    override public func item(at indexPath: IndexPath) -> T? {
        return items[indexPath.row]
    }
}
