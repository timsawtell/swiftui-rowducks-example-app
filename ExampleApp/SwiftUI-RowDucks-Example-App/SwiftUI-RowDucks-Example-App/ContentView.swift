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
    
    func onTapName() {
        store.dispatch(action: ChangeNameAction(newName: "Bob"))
    }
    
    func onTapData() {
        store.dispatch(action: AddAnotherItemAction())
    }
    
    var body: some View {
        VStack {
            Text("First Name: \(store.state!.ui.name)")
            Text("Last Name: \(store.state!.ui.otherName)")
            
            Button(action: onTapName) {
                Text("Change First Name")
                }.padding(10)
            
            Text("Other Data:")
            HStack {
                ForEach(store.state!.data.items) { item in
                    Text(String(item))
                }
            }
            
            Button(action: onTapData) {
                Text("Insert more data")
                }.padding(10)
        
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
