//
//  ContentView.swift
//  SwiftUI-RowDucks-Example-App
//
//  Created by Tim Sawtell on 10/6/19.
//  Copyright © 2019 Tim Sawtell. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView : View {
    var body: some View {
        VStack {
            NamesView()
                .padding()
            ItemsView()
                .padding()
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
