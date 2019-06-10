//
//  UI.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

struct UIReducer: Reducer {
    typealias ResponsibleData = UI
    
    var nameReducer = UINameReducer()
    var otherNameReducer = UIOtherNameReducer()
    
    func reduce(state: UI?, action: Action) -> UI {
        let name = nameReducer.reduce(state: state?.name, action: action)
        let otherName = otherNameReducer.reduce(state: state?.otherName, action: action)
        
        return UI(name: name, otherName: otherName)
    }
}

struct UINameReducer: Reducer {
    typealias responsibleData = String
    
    func reduce(state: String?, action: Action) -> String {
        switch action {
        case .Initialize:
            return "Tim"
        case .ChangeName:
            return "Frank"
        default:
            return state ?? ""
        }
    }
}

struct UIOtherNameReducer: Reducer {
    typealias responsibleData = String
    
    func reduce(state: String?, action: Action) -> String {
        switch action {
        case .Initialize:
            return "Frank"
        default:
            return state ?? ""
        }
    }
}
