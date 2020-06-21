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
    
    var body: some View {
        NavigationView {
            VStack(){
                getWelcomeView()
                NavigationLink(destination: LoginView(), isActive: $pushLoginActive) {
                    Text("")
                }.hidden()
                Spacer()
                Group{
                    if appData.userName == nil{
                        EmptyView()
                    }else{
                        Button(action: {
                            self.appData.userName = nil
                            self.toLogin()
                        }){
                            Text("退出登录")
                        }
                    }
                }
            }
        }.onAppear{
            if self.appData.userName == nil{
                self.toLogin()
            }
        }
    }
    
    private func getWelcomeView () -> some View {
        if let userName = appData.userName{
            return AnyView(Text("欢迎，\(userName)").font(.title))
        } else {
            return AnyView(Button(action: {self.toLogin()}){
                Text("请登录").font(.headline)
            })
        }
    }
    
    private func toLogin(){
        pushLoginActive = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
