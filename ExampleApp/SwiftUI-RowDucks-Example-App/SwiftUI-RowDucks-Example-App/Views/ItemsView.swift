//
//  ItemsView.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 16/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import SwiftUI
import Combine

struct ItemsView : View {
    
    @ObjectBinding var provider = viewModelMapperInstance
    
    func onTapData() {
        provider.store.dispatch(action: AddAnotherItemAction())
    }
    
    func onAsyncActionTap() {
        provider.store.dispatch(asyncAction: AsynchronouslyAddRandomItem())
    }
    
    var body: some View {
        VStack {
            Text("Data Items:")
            Text(provider.viewModel.itemsString)
                .lineLimit(nil)
            
            Button(action: onTapData) {
                Text("Insert more data")
            }
            
            Button(action: onAsyncActionTap) {
                Text("Asynchronously insert more data")
            }
        }
    }
}

#if DEBUG
struct ItemsView_Previews : PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
#endif

/// This is the view model that this one `View` cares about.
struct ItemsViewModel: Equatable {
    var itemsString: String
}

/// Turn the global state object into a single View Model publisher
class ItemsViewModelMapper : BindableObject {
    var viewModel: ItemsViewModel = ItemsViewModel(itemsString: "")
    var didChange = PassthroughSubject<ItemsViewModel, Never>()
    var subscription: Subscription?
    var store: Store {
        return storeInstance
    }
    
    init() {
        // make this instance _care_ about the store changing state by subscribing
        // to it's `PassthroughSubject`
        storeInstance.didChange.subscribe(self)
        // establish the view model based on the current app state
        mapStateToViewModel(storeInstance.state)
    }
}

extension ItemsViewModelMapper: Subscriber {
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
        
        var string: String = input.data.items.reduce("", { x, y in
            x + String(y) + ", "
        })
        string.removeLast(2)
        
        viewModel = ItemsViewModel(itemsString: string)
        
        if previousViewModel != viewModel {
            didChange.send(viewModel)
        }
    }
    
    func receive(subscription: Subscription) {
        self.subscription = subscription
        self.subscription?.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {}
}

fileprivate let viewModelMapperInstance = ItemsViewModelMapper()
