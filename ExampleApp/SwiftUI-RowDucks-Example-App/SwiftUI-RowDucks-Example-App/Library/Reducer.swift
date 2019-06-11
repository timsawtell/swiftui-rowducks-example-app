//
//  Reducers.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

/// Base `Action` has no members or functions
protocol Action {
    
}

protocol AsyncAction {
    associatedtype MyStore
    var closure: (MyStore) -> Void { get set }
}

/// Used when setting up the state so that the default values are applied
struct InitAction: Action {}

/// A `Reducer` is an individual entity that will run a function and return some state.
/// There is usually a 1:1 relationship between each level of your `state` entity graph and
/// a reducer.
protocol Reducer {
    
    /// ResponsibleData means "What struct should I return when I run my `reduce` function
    associatedtype ResponsibleData
    
    /// For a given `state` (potentially nil, as expected before the first run), what should
    /// the `ResponsibleData` look like (change to) based on the `action` that we're working with.
    /// More often than not, the reducer will just return `state`. However when you want a change
    /// to happen, your reducer will return a new `state` based on your rules
    func reduce(state: ResponsibleData?, action: Action) -> ResponsibleData
}
