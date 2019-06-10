//
//  ContentView.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    @ObjectBinding var store = storeInstance
    
    func onTap() {
        store.dispatch(action: .ChangeName)
    }
    
    var body: some View {
        VStack {
            Text(store.state!.ui.name)
            Button(action: onTap) {
                Text("Change Name")
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
#endif
