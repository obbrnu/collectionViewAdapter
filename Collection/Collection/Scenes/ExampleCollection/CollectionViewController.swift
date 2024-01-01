//
//  CollectionViewController.swift
//  Collection
//
//  Created by Александр Бобрун on 31.12.2023.
//

import UIKit
import PinLayout

//enum CellTypes {
//    case colorCell(ColorCellModel)
//    case sizeCell(SizeCellModel)
//}

final class CollectionViewController: UIViewController, UICollectionViewDelegate {
    
    // MARK: - private properties
    
    private let firstPartOfSnapshot: [ReusableModelBox] = [
        ColorCellModel(identifier: UUID().uuidString, color: .red, text: UUID().uuidString).box(),
        ColorCellModel(identifier: UUID().uuidString, color: .yellow, text: UUID().uuidString).box(),
        SizeCellModel(identifier: UUID().uuidString, size: CGSize(width: 200, height: 100)).box(),
        SizeCellModel(identifier: UUID().uuidString, size: CGSize(width: 250, height: 50)).box(),
        SizeCellModel(identifier: UUID().uuidString, size: CGSize(width: 150, height: 40)).box(),
        TestCellModel(identifier: UUID().uuidString, imageName: "testImage").box(),
        ColorCellModel(identifier: UUID().uuidString, color: .magenta, text: "test").box(),
        ColorCellModel(identifier: UUID().uuidString, color: .green, text: UUID().uuidString).box()
    ]
    
    private let secondPartOfSnapshot: [ReusableModelBox] = [
        ColorCellModel(identifier: UUID().uuidString, color: .blue, text: UUID().uuidString).box(),
        ColorCellModel(identifier: UUID().uuidString, color: .blue, text: UUID().uuidString).box(),
        SizeCellModel(identifier: UUID().uuidString, size: CGSize(width: 300, height: 200)).box(),
        SizeCellModel(identifier: UUID().uuidString, size: CGSize(width: 100, height: 70)).box(),
        TestCellModel(identifier: UUID().uuidString, imageName: "testImage").box(),
        SizeCellModel(identifier: UUID().uuidString, size: CGSize(width: 250, height: 100)).box(),
        TestCellModel(identifier: UUID().uuidString, imageName: "testImage").box(),
        TestCellModel(identifier: UUID().uuidString, imageName: "testImage").box(),
        ColorCellModel(identifier: UUID().uuidString, color: .blue, text: "test").box(),
        ColorCellModel(identifier: UUID().uuidString, color: .blue, text: UUID().uuidString).box()
    ]
    
    private let collectionViewAdapter : CollectionViewAdapter = {
        let layout = UICollectionViewFlowLayout()
        let adapter = CollectionViewAdapter(layout: layout)
        
        return adapter
    }()
    
    // MARK: - methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionViewAdapter.collectionView)
        
        setup()
        setupCollectionView()
        setupLayout()
    }
    
    // MARK: - private methods
    
    private func setup() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupCollectionView() {
        
        collectionViewAdapter.collectionView.backgroundColor = .lightGray
        
        let sections: [SectionModel] = [
            SectionModel(identifier: "firstSection", items: firstPartOfSnapshot),
            SectionModel(identifier: "secondSection", items: secondPartOfSnapshot)
        ]
        collectionViewAdapter.apply(with: Snapshot(sections: sections))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) { [weak self] in
            let sections: [SectionModel] = [
                SectionModel(identifier: "secondSection", items: self?.secondPartOfSnapshot ?? []),
                SectionModel(identifier: "firstSection", items: self?.firstPartOfSnapshot ?? [])
            ]
            self?.collectionViewAdapter.apply(with: Snapshot(sections: sections))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) { [weak self] in
            let sections: [SectionModel] = [
                SectionModel(identifier: "firstSection", items: self?.firstPartOfSnapshot ?? []),
                SectionModel(identifier: "secondSection", items: self?.secondPartOfSnapshot ?? [])
            ]
            self?.collectionViewAdapter.apply(with: Snapshot(sections: sections))
        }
    }

    private func setupLayout() {
        
        view.addSubview(collectionViewAdapter.collectionView)
        
        collectionViewAdapter.collectionView.pin
            .top(view.safeAreaInsets.top)
            .horizontally()
            .bottom()
    }
}
