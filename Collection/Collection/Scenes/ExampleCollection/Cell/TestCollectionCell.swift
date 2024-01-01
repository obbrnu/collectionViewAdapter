//
//  TestCollectionCell.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit

struct TestCellModel: ReusableModel {
    typealias View = TestCollectionCell
    
    let identifier: String
    let imageName: String
}

final class TestCollectionCell: UICollectionViewCell, ReusableCollectionCell {
    
    // MARK: - private properties
    
    private let testImageView = UIImageView()
    
    // MARK: - methods
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        testImageView.pin.all()
    }
    
    func configure(with model: TestCellModel) {
        testImageView.image = UIImage(named: model.imageName)
    }
    
    static func size(for model: TestCellModel, availableWidth: CGFloat) -> CGSize {
        return CGSize(width: availableWidth, height: 60)
    }
    
    // MARK: - private methods
    
    private func setup() {
        contentView.addSubview(testImageView)
    }
}
