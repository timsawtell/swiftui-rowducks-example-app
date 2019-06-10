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
    typealias responsibleData = [Int]
    
    func reduce(state: [Int]?, action: Action) -> [Int] {
        switch action {
        case .Initialize:
            return [1, 2, 3]
        default:
            return state ?? []
        }
    }
}

struct DataOtherItemsReducer: Reducer {
    typealias responsibleData = [Int]
    
    func reduce(state: [Int]?, action: Action) -> [Int] {
        switch action {
        case .Initialize:
            return [4, 5, 6]
        default:
            return state ?? []
        }
    }
}
