//
//  ExampleMenuViewController.swift
//  UIDeskViewController
//
//  Created by ddraiman1990 on 02/04/2020.
//  Copyright (c) 2020 ddraiman1990. All rights reserved.
//

import UIKit
import UIDeskViewController

class ExampleMenuViewController: UIViewController {
    
    // MARK: - Methods | Button Actions
    
    @IBAction func fetchResultsExampleTapped(_ sender: Any) {
        let vc = FetchResultsExampleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func itemsExampleTapped(_ sender: Any) {
        let vc = ItemsExampleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

