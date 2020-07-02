//
//  StartView.swift
//  robochat
//
//  Created by 董超 on 2020/6/30.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        ZStack{
            ContentView().zIndex(0)
            if appData.showLogin {
                LoginView().transition(.move(edge: .bottom)).zIndex(1)
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
