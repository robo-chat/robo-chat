//
//  ContentView.swift
//  robochat
//
//  Created by 王庆 on 2020/5/26.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI
let lightGreyColor = Color(red: 243.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct seperator: View {
    var body: some View {
        VStack {
            Divider().background(lightGreyColor)
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
