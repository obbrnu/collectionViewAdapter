//
//  AdapterHelpers.swift
//  Collection
//
//  Created by Александр Бобрун on 01.01.2024.
//

import Foundation
import DifferenceKit

struct Snapshot {
    
    let sections: [SectionModel]
}

struct SectionModel {
    
    let identifier: String
    let items: [ReusableModelBox]
    
    func copy(items: [ReusableModelBox] = []) -> SectionModel {
        
        let model = SectionModel(identifier: self.identifier,
                                items: items)
        
        return model
    }
}

extension SectionModel: Differentiable {
   
    var differenceIdentifier: String {
        return identifier
    }
}

extension SectionModel: Equatable {
    
    public static func == (lhs: SectionModel, rhs: SectionModel) -> Bool {
        return lhs.identifier == rhs.identifier && StagedChangeset(source: lhs.items, target: rhs.items).isEmpty
    }
}

