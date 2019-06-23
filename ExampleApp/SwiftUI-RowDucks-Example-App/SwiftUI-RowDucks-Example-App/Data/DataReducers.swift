//
//  Data.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation
import SwiftUI_RowDucks

struct DataReducer: Reducer {
    typealias ResponsibleData = Data
    
    static func reduce(state: Data?, action: Action) -> Data {
        let items = DataItemsReducer.reduce(state: state?.items, action: action)
        let otherItems = DataOtherItemsReducer.reduce(state: state?.otherItems, action: action)
        return Data(items: items, otherItems: otherItems)
    }
}

struct DataItemsReducer: Reducer {
    
    typealias ResponsibleData = [Int]
    
    static func reduce(state: [Int]?, action: Action) -> [Int] {
        switch action {
        case is AddAnotherItemAction:
            var modified = state!
            modified.append((modified.max())! + 1)
            return modified
        default:
            break
        }

        return state ?? [1, 2, 3]
    }
}

struct DataOtherItemsReducer: Reducer {
    
    typealias ResponsibleData = [Int]
    
    static func reduce(state: [Int]?, action: Action) -> [Int] {
        return state ?? [4, 5, 6]
    }
}
