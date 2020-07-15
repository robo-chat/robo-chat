//
//  TesView.swift
//  robochat
//
//  Created by yangting on 2020/7/8.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct TesView: View {
    @State private var name: String = ""
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your name is \(name)")
                }
                Group {
                    Text("Hello World3")
                    Text("Hello World4")
                }
                Group {
                    Text("Hello World")
                    Text("Hello World4")
                    Text("Hello World5")
                }
                Section {
                    Text("Hello World")
                    Text("Hello World2")
                }
                Group {
                    ForEach(0 ..< 10) { number in
                        Text("Row \(number)")
                    }
                }
                
            }.navigationBarTitle("Swift")
        }
    }
}

struct TesView_Previews: PreviewProvider {
    static var previews: some View {
        TesView()
    }
}
