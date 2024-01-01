//
//  CollectionViewAdapter.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import Foundation
import UIKit
import DifferenceKit

final class CollectionViewAdapter: NSObject {
    
    // MARK: - properties
    
    let collectionView: UICollectionView
    
    // MARK: - private properties
    
    private var registrationCache: [String: Bool] = [:]
    private var snapshot: Snapshot = Snapshot(sections: [])
    
    // MARK: - methods
    
    // MARK: init
    
    init(layout: UICollectionViewLayout) {
        
        self.collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: layout)
        
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func apply(with snapshot: Snapshot) {
        
        let source = self.snapshot.sections.map { ArraySection(model: $0, elements: $0.items) }
        let target = snapshot.sections.map { ArraySection(model: $0, elements: $0.items) }
        
        let changeset = StagedChangeset(source: source, target: target)

        collectionView.reload(using: changeset, interrupt: { $0.changeCount > 100 }) { data in
            let sections = data.map { (array) in
                let items = array.elements
                let oldSection = array.model
                let model = oldSection.copy(items: items)
                return model
            }
            
            self.snapshot = Snapshot(sections: sections)
        }
    }
}

extension CollectionViewAdapter: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return snapshot.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return snapshot.sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = snapshot.sections[indexPath.section].items[indexPath.item]
        
        if registrationCache[model.viewType.reusableIdentifier] == nil {
            collectionView.register(for: model.viewType)
            registrationCache[model.reusableIdentifier] = true
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reusableIdentifier,
                                                            for: indexPath) as? (any ReusableCollectionCell) else {
            return UICollectionViewCell()
        }
        
        model.configurationBlock(cell)
        
        return cell
    }
}

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let model = snapshot.sections[indexPath.section].items[indexPath.item]
        
        return model.sizeCalculationBlock(collectionView.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let model = snapshot.sections[indexPath.section].items[indexPath.item]
        print("Did select item at \(indexPath) with model: \(model)")
    }
}

