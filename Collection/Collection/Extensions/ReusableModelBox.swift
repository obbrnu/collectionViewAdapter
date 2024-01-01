//
//  ReusableModelBox.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit
import DifferenceKit

extension ReusableModel {
    
    func box() -> ReusableModelBox {
        return ReusableModelBox(model: self)
    }
}

struct ReusableModelBox {
    
    let reusableIdentifier: String
    let sizeCalculationBlock: (CGFloat) -> CGSize
    let configurationBlock: (UICollectionViewCell) -> Void
    let viewType: any ReusableCollectionCell.Type
    let equalBlock: (Any) -> Bool
    let model: any ReusableModel
    let identifier: AnyHashable
    
    init<M: ReusableModel>(model: M) {
        
        self.reusableIdentifier = M.View.reusableIdentifier
        self.model = model
        self.identifier = model.identifier 
        
        sizeCalculationBlock = { width -> CGSize in
            return model.viewType.size(for: model, availableWidth: width)
        }
        
        configurationBlock = { view in
            guard let reusableView = view as? M.View else {
                fatalError("\(#function) error cast")
            }
            reusableView.configure(with: model)
        }
        
        equalBlock = { m in
            guard let otherModel = m as? M else {
                return false
            }
            
            return model == otherModel
        }
        
        self.viewType = model.viewType
    }
}

extension ReusableModelBox: Equatable {
    
    static func == (lhs: ReusableModelBox, rhs: ReusableModelBox) -> Bool {
        return lhs.equalBlock(rhs.model)
    }
}

extension ReusableModelBox: Differentiable {
    
    var differenceIdentifier: String {
        return "\(identifier)"
    }
}

