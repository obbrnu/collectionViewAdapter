//
//  ColorCollectionCell.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit
import PinLayout

struct ColorCellModel: ReusableModel {
    typealias View = ColorCollectionCell
    
    let identifier: String
    let color: UIColor
    let text: NSAttributedString
    
    init(identifier: String, color: UIColor, text: String) {
        
        self.identifier = identifier
        self.color = color
        self.text = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 20)])
    }
}



final class ColorCollectionCell: UICollectionViewCell, ReusableCollectionCell {
    
    //MARK: - private types
    
    private enum ConstantsForCell {
        static let separatorHeight: CGFloat = 2
    }
    
    //MARK: - properties
    
    private let containerView = UIView()
    private let textLabel = UILabel()
    private let separatorView = UIView()
    
    //MARK: - methods
    
    //MARK: init
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupContainerView()
        setupLabel()
        setupSeparatorView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    func configure(with model: ColorCellModel) {
        
        contentView.backgroundColor = model.color
        textLabel.attributedText = model.text
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    //MARK: height calc
    
//    static func height(with model: ColorCellModel, width: CGFloat) -> CGFloat {
//        let height = model.text.height(withConstrainedWidth: width)
//
//        return height + 10
//    }
    
    static func size(for model: ColorCellModel, availableWidth: CGFloat) -> CGSize {
        let height = model.text.height(withConstrainedWidth: availableWidth) + 10
        
        return CGSize(width: availableWidth, height: height)
    }

    
    //MARK: - private methods
    
    private func layout() {
        
        setupContainerViewLayout()
        setupLabelLayout()
        setupSeparatorViewLayout()
    }
    
    private func setupContainerView() {
        
        contentView.addSubview(containerView)
    }
    
    private func setupContainerViewLayout() {
        
        containerView.pin.all()
    }
    
    private func setupLabel() {
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
//        textLabel.lineBreakMode = .byTruncatingHead
        containerView.addSubview(textLabel)
    }
    
    private func setupLabelLayout() {
        
        textLabel.pin.all()
        
        textLabel.pin.wrapContent(.vertically)
    }
    
    private func setupSeparatorView() {
        separatorView.backgroundColor = .gray
        
        containerView.addSubview(separatorView)
    }
    
    private func setupSeparatorViewLayout() {
        
        separatorView.pin
            .horizontally()
            .bottom()
            .height(ConstantsForCell.separatorHeight)
    }
}
