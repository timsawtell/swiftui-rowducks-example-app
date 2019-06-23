//
//  NamesView.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 16/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import SwiftUI
import Combine

struct NamesView : View {
    @ObjectBinding var provider = NamesViewModelMapper()
    
    func onTapName() {
        provider.store.dispatch(action: ChangeNameAction(newName: "Timothy"))
    }
    
    var body: some View {
        VStack {
            Text("First Name: \(provider.viewModel.firstName)")
            Text("Last Name: \(provider.viewModel.lastName)")
            
            Button(action: onTapName) {
                Text("Change First Name")
            }
        }
    }
}

#if DEBUG
struct NamesView_Previews : PreviewProvider {
    static var previews: some View {
        NamesView()
    }
}
#endif

/// This is the view model that this one `View` cares about.
struct NamesViewModel: Equatable {
    var firstName: String
    var lastName: String
}

/// Turn the global state object into a single View Model publisher
class NamesViewModelMapper : BindableObject {
    var viewModel = NamesViewModel(firstName: "", lastName: "")
    var didChange = PassthroughSubject<NamesViewModel, Never>()
    var storeSubscription: Subscription?
    var store: Store {
        return storeInstance
    }
    
    init() {
        // make this instance _care_ about the store changing state by subscribing
        // to it's `PassthroughSubject`
        store.didChange.subscribe(self)
        // establish the view model based on the current app state
        mapStateToViewModel(store.state)
    }
}

extension NamesViewModelMapper: Subscriber {
    typealias Input = DemoAppState
    typealias Failure = Never
    
    /// Turn the whole state object into a tiny little view model, and then
    /// publish a change to any of _my_ subscribers via my own `didChange`
    /// call
    func receive(_ input: DemoAppState) -> Subscribers.Demand {
        mapStateToViewModel(input)
        return .unlimited
    }
    
    func mapStateToViewModel(_ input: DemoAppState) {
        let previousViewModel = viewModel
        viewModel = NamesViewModel(firstName: input.ui.name, lastName: input.ui.otherName)
        if previousViewModel != viewModel {
            didChange.send(viewModel)
        }
    }
    
    func receive(subscription: Subscription) {
        storeSubscription = subscription
        storeSubscription?.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) { }
}
