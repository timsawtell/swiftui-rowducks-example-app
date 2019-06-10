//
//  Store.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct DemoAppState: Equatable {
    static func == (lhs: DemoAppState, rhs: DemoAppState) -> Bool {
        return lhs.ui == rhs.ui && lhs.ui == rhs.ui
    }
    
    var ui: UI
    var data: Data
}

struct UI: Equatable {
    var name: String
    var otherName: String
}

struct Data: Equatable {
    var items: [Int]
    var otherItems: [Int]
}

struct DemoAppMainReducer : Reducer {
    typealias ResponsibleData = DemoAppState
    let uiReducer = UIReducer()
    let dataReducer = DataReducer()
    
    func reduce(state: DemoAppState?, action: Action) -> DemoAppState {
        return DemoAppState(ui: uiReducer.reduce(state: state?.ui, action: action),
                            data: dataReducer.reduce(state: state?.data, action: action))
    }
}

class Store: BindableObject {
    var didChange = PassthroughSubject<DemoAppMainReducer.ResponsibleData?, Never>()
    
    internal var state: DemoAppMainReducer.ResponsibleData?
    internal var myReducer: DemoAppMainReducer?
    
    class func createStore<T: Reducer>(_ reducer: T) -> Store {
        let store: Store = Store()
        store.state = reducer.reduce(state: nil, action: .Initialize) as? DemoAppMainReducer.ResponsibleData
        store.myReducer = reducer as? DemoAppMainReducer
        return store
    }
    
    func dispatch(action: Action) {
        let beforeState = state
        state = myReducer?.reduce(state: state, action: action)
        if state != beforeState {
            // found that the state is different after that Action, notify subscribers
            didChange.send(state)
        }
    }
    
    func getState() -> DemoAppMainReducer.ResponsibleData {
        return state!
    }
    
}

var storeInstance = Store.createStore(DemoAppMainReducer())

