//
//  UIDeskEmptyStateView.swift
//  UIDeskViewController
//
//  Created by Dan Draiman on 2/5/20.
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

public class UIDeskEmptyStateView: UIView {

    // MARK: - Helpers | Enums
    struct LabelConfig {
        var text: String
        let font: UIFont
        let color: UIColor
        let numOfLines: Int
    }
    
    struct IconConfig {
        var image: UIImage
        let contentMode: ContentMode
        let tintColor: UIColor
    }
    
    // MARK: - Properties | Default
    
    private let defaultTitleConfig = LabelConfig(
        text: "",
        font: UIFont.systemFont(ofSize: 16, weight: .bold),
        color: UIColor.black,
        numOfLines: 1)
    
    private let defaultDescriptionConfig = LabelConfig(
    text: "",
    font: UIFont.systemFont(ofSize: 16, weight: .regular),
    color: UIColor.darkGray,
    numOfLines: 4)
    
    private let defaultIconConfig = IconConfig(
        image: UIImage(),
        contentMode: .scaleAspectFit,
        tintColor: .black)
    
    // MARK: - Properties | UI
    
    private let titleLabel: UILabel
    private let descriptionLabel: UILabel
    private let iconImageView: UIImageView?
    private let stackView: UIStackView
    
    // MARK: - Methods | Lifecycle
    
    init(frame: CGRect, title: LabelConfig, description: LabelConfig, icon: IconConfig?) {
        stackView = UIStackView()
        titleLabel = UILabel()
        descriptionLabel = UILabel()
        iconImageView = (icon != nil) ? UIImageView() : nil
        super.init(frame: frame)
        setupSubviews(titleConfig: title,
                      descriptionConfig: description,
                      iconConfig: icon)
    }
    
    init(frame: CGRect, title: String, description: String, icon: UIImage?) {
        stackView = UIStackView()
        titleLabel = UILabel()
        descriptionLabel = UILabel()
        iconImageView = (icon != nil) ? UIImageView() : nil
        super.init(frame: frame)
        
        var defaultTitle = defaultTitleConfig
        defaultTitle.text = title
        
        var defaultDescription = defaultDescriptionConfig
        defaultDescription.text = description
        
        var defaultIcon: IconConfig?
        if let icon = icon {
            defaultIcon = defaultIconConfig
            defaultIcon?.image = icon
        }

        setupSubviews(titleConfig: defaultTitle,
                      descriptionConfig: defaultDescription,
                      iconConfig: defaultIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods | Setup
    
    private func setupSubviews(titleConfig: LabelConfig,
                               descriptionConfig: LabelConfig,
                               iconConfig: IconConfig?) {
        setup(stack: stackView)
        if let iconConfig = iconConfig, let imageView = iconImageView {
            setup(imageView: imageView, config: iconConfig)
        }
        setup(label: titleLabel, config: titleConfig)
        setup(label: descriptionLabel, config: descriptionConfig)
    }
    
    private func setup(stack: UIStackView) {
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stack)
        stack
            .topAnchor
            .constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: 16)
            .isActive = true
        stack
            .bottomAnchor
            .constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
            .isActive = true
        stack
            .leadingAnchor
            .constraint(equalTo: leadingAnchor, constant: 26)
            .isActive = true
        stack
            .trailingAnchor
            .constraint(equalTo: trailingAnchor, constant: -26)
            .isActive = true
        stack
            .centerYAnchor
            .constraint(equalTo: centerYAnchor)
            .isActive = true
        stack
            .centerXAnchor
            .constraint(equalTo: centerXAnchor)
            .isActive = true
    }
    
    private func setup(label: UILabel, config: LabelConfig) {
        stackView.addArrangedSubview(label)
        label.textAlignment = .center
        label.text = config.text
        label.numberOfLines = config.numOfLines
        label.font = config.font
        label.textColor = config.color
    }
    
    private func setup(imageView: UIImageView, config: IconConfig) {
        stackView.addArrangedSubview(imageView)
        imageView.image = config.image
        imageView.contentMode = config.contentMode
        imageView.tintColor = config.tintColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView
            .heightAnchor
            .constraint(equalTo: heightAnchor, multiplier: 0.3)
            .isActive = true
    }
}

