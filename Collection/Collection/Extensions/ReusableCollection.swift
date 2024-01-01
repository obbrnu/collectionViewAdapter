//
//  ReusableCollection.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit

protocol ReusableModel: Equatable {
    associatedtype View: ReusableCollectionCell where View.Model == Self
    associatedtype Id: Hashable
    
    var viewType: View.Type { get }
    var identifier: Id { get }
}

extension ReusableModel {
    
    var viewType: View.Type {
        return View.self
    }
}

protocol ReusableCollectionCell: UICollectionViewCell {
    associatedtype Model: ReusableModel where Model.View == Self
    
    static var reusableIdentifier: String { get }
    
    func configure(with model: Model)
    
    static func size(for model: Model, availableWidth: CGFloat) -> CGSize 
}

extension ReusableCollectionCell {
    
    static var reusableIdentifier: String {
        return NSStringFromClass(self)
    }
}
