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
        return lhs.ui == rhs.ui && lhs.data == rhs.data
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

/// The top most `Reducer` in the app. For every action that is dispatched, this is the reducer that is run.
/// This reducer will shard off responsibility for it's various sections of the object graph to the
/// appropriate reducer, i.e for the `UI` section of `DemoAppState`, it uses the resulting value of the
/// `UIReducer`'s reduce function.
///
/// Reducers are composable (by coincidence, not by language) and can call other reducers.
///
/// This gives the programmer the ability to shard off whole sections of the app `State` to separate swift
/// files, maintained by different programmers, if you happen to work in a team.
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
    /// Implement the `BindableObject` protocol 
    internal var didChange = PassthroughSubject<DemoAppState, Never>()
    
    /// The top most reducer for this Store
    fileprivate var mainReducer = DemoAppMainReducer()
    
    /// Hide `internalState` from modifications by marking it as fileprivate
    fileprivate var internalState: DemoAppState
    
    /// `state` is a read-only property that returns `internalState`. The rest of the app reads this.
    var state: DemoAppState {
        return internalState
    }
    
    /// Let the `state` object get populated by the default values returned by all the reducers in
    /// the `DemoAppMainReducer`'s `reduce` function call
    init() {
        self.internalState = mainReducer.reduce(state: nil, action: InitAction())
    }
    
    /// Grab a copy of `state`. Run your main reducer with this `action` and then
    /// compare the new `state` against the old `state`. If there is a difference,
    /// tell SwiftUI that it needs to layout its views again via the `BindableObject`
    /// `didChange` function.
    func dispatch(action: Action) {
        let beforeState = state
        internalState = mainReducer.reduce(state: internalState, action: action)
        if internalState != beforeState {
            // found that the state is different after that Action, notify subscribers
            didChange.send(state)
        }
    }
    
    /// Run the `asyncAction`'s closure and pass in self, so that the closure can
    /// then call `dispatch` on self (to actually make changes to the state)
    func dispatch<T: AsyncAction>(asyncAction: T) {
        asyncAction.closure(self as! T.MyStore)
    }
}

var storeInstance = Store()
