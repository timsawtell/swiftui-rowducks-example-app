//
//  DemoAppMiddleware.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 15/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

class BaseMiddleware: MiddlewareItem {
    func observeStateChange(withBeforeState beforeState: DemoAppState, afterState: DemoAppState, action: Action) {
        // nothing
    }
    
    typealias ResponsibleData = DemoAppState
}

class LoggerMiddleware : BaseMiddleware {
    override func observeStateChange(withBeforeState beforeState: DemoAppState, afterState: DemoAppState, action: Action) {
        NSLog("LoggerMiddleware: here because of action: \(action)")
    }
}

class TrackingMiddleware : BaseMiddleware {
    override func observeStateChange(withBeforeState beforeState: DemoAppState, afterState: DemoAppState, action: Action) {
        switch action {
        case is ChangeNameAction:
            NSLog("tell your chosen tracking library something")
        default:
            break
        }
    }
}
