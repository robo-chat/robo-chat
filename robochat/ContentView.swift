//
//  ContentView.swift
//  robochat
//
//  Created by 王庆 on 2020/5/26.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var pushLoginActive = false
    @EnvironmentObject var appData: AppData
    
    var logined: Bool {
        get{ return appData.userName != nil }
    }
    
    var body: some View {
        NavigationView {
            VStack(){
                if logined {
                    Text("欢迎，\(appData.userName ?? "")").font(.title)
                } else {
                    Button(action: {self.toLogin()}){
                        Text("请登录").font(.headline)
                    }
                }
                NavigationLink(destination: LoginView(), isActive: $pushLoginActive) {
                    Text("")
                }.hidden()
                Spacer()
                if logined {
                    Button(action: logout){
                        Text("退出登录")
                    }
                }
            }
        }.onAppear{
            if !self.logined {
                self.toLogin()
            }
        }
    }
    
    private func toLogin(){
        pushLoginActive = true
    }
    
    private func logout(){
        appData.userName = nil
        toLogin()
    }
}

struct ContentView_Previews: PreviewProvider {
    static let appData = AppData()
    static var previews: some View {
        ContentView().environmentObject(appData)
    }
}
