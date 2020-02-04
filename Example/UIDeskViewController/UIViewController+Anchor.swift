//
//  UIView+Anchor.swift
//  UIDeskViewController_Example
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
