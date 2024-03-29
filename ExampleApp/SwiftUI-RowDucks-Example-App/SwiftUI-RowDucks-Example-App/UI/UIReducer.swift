//
//  UI.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation
import SwiftUI_RowDucks

struct UIReducer: Reducer {
    typealias ResponsibleData = UI
    
    static func reduce(state: UI?, action: Action) -> UI {
        
        // Because I want fine-grained control over this `UI` struct's value, I will
        // run reducers on each entity in the `UI` struct.
        // I don't have to. I could simply compose the `UI` struct right here and
        // return it - but I defer to other reducers (UINameReducer, UIOtherNameReducer)
        // to illustrate that you can compose the result for a reduce function by calling
        // other dedicated reducers.
        let name = UINameReducer.reduce(state: state?.name, action: action)
        let otherName = UIOtherNameReducer.reduce(state: state?.otherName, action: action)
        
        return UI(name: name, otherName: otherName)
    }
}

struct UINameReducer: Reducer {
    typealias ResponsibleData = String
    
    static func reduce(state: String?, action: Action) -> String {
        
        switch action {
        case is ChangeNameAction:
            // The ChangeNameAction has an affect on the `name` string of the UI struct
            return (action as! ChangeNameAction).newName
        default:
            // Just return state (i.e. don't modify the value) - and if state is nil, return
            // the default value. Up to the programmer to determine what that is.
            return state ?? "Tim"
        }
    }
}

struct UIOtherNameReducer: Reducer {
    typealias ResponsibleData = String
    
    static func reduce(state: String?, action: Action) -> String {
        return state ?? "Sawtell"
    }
}
