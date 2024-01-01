//
//  SizeCollectionCell.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit

struct SizeCellModel: ReusableModel {
    typealias View = SizeCollectionCell
    
    let identifier: String
    let size: CGSize
}

final class SizeCollectionCell: UICollectionViewCell, ReusableCollectionCell {
    
    // MARK: - methods
    
    // MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: SizeCellModel) {
        
    }
    
    //MARK: size calc
    
    static func size(for model: SizeCellModel, availableWidth: CGFloat) -> CGSize {
        return model.size
    }
    
    // MARK: - private methods
    
    private func setup() {
        contentView.backgroundColor = .black
    }
}
