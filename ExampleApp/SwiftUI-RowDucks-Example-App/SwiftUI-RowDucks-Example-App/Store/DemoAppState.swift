//
//  DemoAppState.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 15/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

// Here is where you build up one single struct that must confrom
// to the `Equatable` protocol

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
