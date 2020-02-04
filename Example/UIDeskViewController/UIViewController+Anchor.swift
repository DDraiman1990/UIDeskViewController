//
//  UIView+Anchor.swift
//  UIDeskViewController_Example
//
//  Created by Dan Draiman on 2/4/20.
//  Copyright © 2020 Nexxmark Studio. All rights reserved.
//

import UIKit

extension UIViewController{
    
    /// Will embed the desired view controller in this view controller, inside the specified container view.
    /// - Parameter viewControllerToEmbed: the view controller to become the child of this view controller.
    /// - Parameter containerView: optional UIView. if left nil, will embed in this view controller's content UIView.
    func embed(_ viewControllerToEmbed: UIViewController, containerView: UIView? = nil){
        viewControllerToEmbed.willMove(toParentViewController: self)
        addChildViewController(viewControllerToEmbed)
        let container = containerView ?? self.view
        container?.embed(viewControllerToEmbed.view)
        viewControllerToEmbed.didMove(toParentViewController: self)
    }
}


extension UIView{
    
    /// Will embed the desired view in this UIView.
    /// - NOTE: uses NSLayoutConstraints so the viewToEmbed's translatesAutoresizingMaskIntoConstraints is set to false.
    /// - Parameter viewToEmbed: the view to be embedded in this UIView.
    func embed(_ viewToEmbed: UIView){
        addSubview(viewToEmbed)
        viewToEmbed.translatesAutoresizingMaskIntoConstraints = false
        
        viewToEmbed.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewToEmbed.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        viewToEmbed.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewToEmbed.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    }
}
