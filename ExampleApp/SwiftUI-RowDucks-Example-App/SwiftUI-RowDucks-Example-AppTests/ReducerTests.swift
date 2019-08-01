//
//  ReducerTests.swift
//  SwiftUI-RowDucks-Example-AppTests
//
//  Created by Tim Sawtell on 15/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import XCTest
import SwiftUI_RowDucks
@testable import SwiftUI_RowDucks_Example_App

class ReducerTests: XCTestCase {
    
    fileprivate var store: SwiftUI_RowDucks_Example_App.Store!
    
    var changeMe = false
    
    override func setUp() {
        store = SwiftUI_RowDucks_Example_App.Store()
    }

    func testBaselineStoreState() {
        let expectedBaselineState = DemoAppState(ui: UI(name: "Tim", otherName: "Sawtell"),
                                                 data: Data(items: [1,2,3], otherItems:[4,5,6]))
        
        XCTAssertEqual(store.state, expectedBaselineState)
    }

    func testActionChangesState() {
        let beforeState = store.state
        store.dispatch(action: ChangeNameAction(newName: "Terrance"))
        let afterState = store.state
        
        XCTAssertNotEqual(beforeState, afterState)
    }

    func testLogicallyIdenticalStatesAreEqual() {
        let beforeState = store.state
        store.dispatch(action: ChangeNameAction(newName: "Terrance"))
        let afterState1 = store.state
        store.dispatch(action: ChangeNameAction(newName: "Terrance"))
        let afterState2 = store.state
        
        XCTAssertNotEqual(beforeState, afterState1)
        XCTAssertEqual(afterState1, afterState2)
    }
    
    func testMyOwnMiddlware() {
        let middleware = TestMiddleware(owner: self)
        let testStore = Store(middleware: [middleware])
        
        // if the middlware worked then it should have changed this property to be true
        
        XCTAssertFalse(changeMe)
        testStore.dispatch(action: TestAction())
        XCTAssertTrue(changeMe)
    }
}

struct TestAction: Action {
    
}

class TestMiddleware: BaseMiddleware {
    override func observeStateChange(withBeforeState beforeState: DemoAppState, afterState: DemoAppState, action: Action) {
        owner?.changeMe = true
    }
    
    typealias ResponsibleData = SwiftUI_RowDucks_Example_App.DemoAppState
    
    let owner: ReducerTests?
    
    init(owner: ReducerTests) {
        self.owner = owner
        super.init()
    }
}
