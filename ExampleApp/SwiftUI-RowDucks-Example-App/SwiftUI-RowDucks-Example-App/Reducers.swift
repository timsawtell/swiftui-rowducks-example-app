//
//  Reducers.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

enum Action {
    case Initialize
    case ChangeName
    case ThirdAction
}

protocol Reducer {
    associatedtype ResponsibleData
    func reduce(state: ResponsibleData?, action: Action) -> ResponsibleData
}
