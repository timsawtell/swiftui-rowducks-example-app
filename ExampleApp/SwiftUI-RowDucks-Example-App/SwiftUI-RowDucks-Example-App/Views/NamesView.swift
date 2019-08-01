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
    @ObservedObject var provider = NamesViewModelMapper()
    
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
class NamesViewModelMapper : ObservableObject {
    @Published var viewModel = NamesViewModel(firstName: "", lastName: "")
    private var storeSubscription: Subscription?
    var store: Store {
        return storeInstance
    }
    
    init() {
        // make this instance _care_ about the store changing state by subscribing
        // to it's `PassthroughSubject`
        store.objectWillChange.subscribe(self)
        // establish the view model based on the current app state
        mapStateToViewModel(store.state)
    }
    
    func mapStateToViewModel(_ input: DemoAppState) {
        // only change viewModel if it's different to the previous value (reduce number or renders)
        let attemptedNewModel = NamesViewModel(firstName: input.ui.name, lastName: input.ui.otherName)
        if (attemptedNewModel != viewModel) {
            // change the value of the `@Publish`ed viewModel property, which will cause Observers (the View) to re-render
            viewModel = attemptedNewModel
        }
    }
}

extension NamesViewModelMapper: Subscriber {
    typealias Input = DemoAppState
    typealias Failure = Never
    
    /// Turn the whole state object into a tiny little view model, and then
    /// publish a change to any of _my_ subscribers in `mapStateToViewModel(input: DemoAppState)`
    func receive(_ input: DemoAppState) -> Subscribers.Demand {
        mapStateToViewModel(input)
        return .unlimited
    }
    
    func receive(subscription: Subscription) {
        storeSubscription = subscription
        storeSubscription?.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) { }
}
