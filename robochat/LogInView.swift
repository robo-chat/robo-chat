//
//  LogInView.swift
//  robochat
//
//  Created by chenmengye on 2020/6/23.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI
//import UIKit

struct LogInView: View {
    
    @State var account: String = ""
    @State var password: String = ""
    @State var isActive = false
     var isCanLogin: Bool {
                account.count > 0 &&
                password.count > 0
            }
    
    var body: some View {
        
        VStack {
            
            Text("微信号/QQ号/邮箱登录")
                        .font(.system(size:30))
                        .padding(.bottom,30)
                        .padding(.trailing,30)
                            
            HStack {
                Text("账号")
                    .font(.system(size:21))
                TextField("微信号/QQ号/邮箱", text: $account)
                    .font(.system(size:21))
                    .padding(.leading)
            }
            .padding(.leading)
    
            Divider()
                .background(Color.gray)
                .padding(.bottom,10)
            
            HStack {
                Text("密码")
                    .font(.system(size:21))
                TextField("请填写密码", text: $password)
                    .font(.system(size:20))
                    .padding(.leading)
            }
            .padding(.leading)
                    
            Divider()
                .background(Color.gray)
                .padding(.bottom,30)
            
            Button(action:{
                self.isActive = true
                self.account="ChenMY"
            }){
                Text("登录")
                   .font(.system(size:25))
               }
            .frame(width: 360, height: 50, alignment: .center)
            .background(isCanLogin ? Color.green: Color.init(#colorLiteral(red: 0.8822754025, green: 0.8824025393, blue: 0.8822476268, alpha: 1)))
            .cornerRadius(5)
            .disabled(!isCanLogin)
            .padding(.bottom,180)
            
//            NavigationLink(destination: ChatBotView(), isActive: $isActive) {
//                           Text("")
//                       }
            
        }
        .frame(maxHeight: .infinity)
        .background(Color.init(#colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)).edgesIgnoringSafeArea(.all))
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView
    }
}
