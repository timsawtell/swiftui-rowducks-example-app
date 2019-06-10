//
//  Data.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

struct DataReducer: Reducer {
    typealias ResponsibleData = Data
    
    var itemsReducer = DataItemsReducer()
    var otherItemsReducer = DataOtherItemsReducer()
    
    func reduce(state: Data?, action: Action) -> Data {
        let items = itemsReducer.reduce(state: state?.items, action: action)
        let otherItems = otherItemsReducer.reduce(state: state?.otherItems, action: action)
        return Data(items: items, otherItems: otherItems)
    }
}

struct DataItemsReducer: Reducer {
    
    typealias ResponsibleData = [Int]
    
    func reduce(state: [Int]?, action: Action) -> [Int] {
        if let _ = action as? AddAnotherItemAction, state != nil {
            var modified = state!
            modified.append((modified.max())! + 1)
            return modified
        }

            return state ?? [1, 2, 3]
        
    }
}

struct DataOtherItemsReducer: Reducer {
    
    typealias ResponsibleData = [Int]
    
    func reduce(state: [Int]?, action: Action) -> [Int] {
        return state ?? [4, 5, 6]
    }
}
