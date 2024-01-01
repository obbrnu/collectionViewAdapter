//
//  UICollectionView+Extensions.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register(for type: any ReusableCollectionCell.Type) {
        register(type, forCellWithReuseIdentifier: type.reusableIdentifier)
    }
}
