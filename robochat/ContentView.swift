//
//  ContentView.swift
//  robochat
//
//  Created by 王庆 on 2020/5/26.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct seperator: View {
    var body: some View {
        VStack {
            Divider().background(Color("normalDivider"))
        }.frame(height: 1, alignment: .center)
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
