//
//  Middleware.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 15/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import Foundation

protocol MiddlewareItem {
    associatedtype ResponsibleData
    
    func observeStateChange(withBeforeState beforeState: ResponsibleData, afterState: ResponsibleData, action: Action)
}
