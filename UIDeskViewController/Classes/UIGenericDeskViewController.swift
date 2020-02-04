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
    
    var configure: CellConfiguration { get set }
    var didSelectRow: RowSelected { get set }
    var determineCellHeight: DetermineCellHeight? { get set }
    var cellCount: Int { get }
    
    init(configure: @escaping CellConfiguration,
         didSelectRow: @escaping RowSelected)
    
    func item(at: IndexPath) -> ModelType?
    func reloadData()
}
