//
//  ContentView.swift
//  robochat
//
//  Created by 王庆 on 2020/5/26.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appData: AppData
    
    var logined: Bool {
        get{ return appData.userName != nil }
    }
    
    var body: some View {
        NavigationView {
            VStack(){
                if logined {
                    Text("欢迎，\(appData.userName ?? "")").font(.title)
                }else{
                    Button(action: toLogin){
                        Text("请登录")
                    }
                }
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
    
    private func logout(){
        appData.userName = nil
        toLogin()
    }
    
    private func toLogin(){
        withAnimation{
            appData.showLogin = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let appData = AppData()
    static var previews: some View {
        ContentView().environmentObject(appData)
    }
}
