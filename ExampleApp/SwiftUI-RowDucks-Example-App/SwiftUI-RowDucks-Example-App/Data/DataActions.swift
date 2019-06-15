//
//  DataActions.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

struct AddAnotherItemAction : Action {
}

class AsynchronouslyAddRandomItem: AsyncAction {
    typealias MyStore = Store
    
    var closure: (MyStore) -> Void = { store in
        
        /// You can do all kinds of things here. Call web APIs,
        /// get data from disc, calculate the square root of an
        /// isosceles triange; this is your time to do your set
        /// of async actions
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            store.dispatch(action: AddAnotherItemAction())
            
            /// Take your time, you have a `store` to work with.
            /// Just be sure to dispatch non `AsyncAction`s
            /// (i.e. an `Action`) if you ever want the `store`'s
            /// `state` to ever change
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                store.dispatch(action: AddAnotherItemAction())
            }
        }
    }
}
