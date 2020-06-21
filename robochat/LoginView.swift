//
//  LoginView.swift
//  robochat
//
//  Created by 董超 on 2020/6/19.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appData: AppData
    
    @State internal var userName: String = ""
    @State internal var password: String = ""
    internal let titleWidth: CGFloat = 92.0
    
    var loginDisabled: Bool{
        get{
            userName.count == 0
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0){
            Text("登录到机器人聊天室").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            VStack(spacing: 0.0) {
                HStack{
                    Text("帐号")
                        .multilineTextAlignment(.leading)
                        .frame(width: titleWidth, alignment: .topLeading)
                    TextField("请填写汉字、英文字母或数字", text: $userName)
                }.padding(.vertical)
                Divider()
                HStack{
                    Text("密码")
                        .multilineTextAlignment(.leading)
                        .frame(width: titleWidth, alignment: .topLeading)
                    SecureField("请填写密码", text: $password)
                }.padding(.vertical)
                Divider()
            }
            Spacer()
                .frame(height: 32.0)
            Button(action: login){
                Text("登录")
            }.disabled(loginDisabled) .buttonStyle(LoginButtonStyle())
            Spacer()
        }.padding(.horizontal, 22.0)
            .frame(maxHeight: .infinity)
            .padding(0.0)
            .navigationBarBackButtonHidden(true)
            .background(Color.init(#colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)).edgesIgnoringSafeArea(.all))
            
    }
    
    private func login(){
        appData.userName = self.userName
        self.presentation.wrappedValue.dismiss()
    }
}

struct LoginButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        StyledButton(configuration: configuration)
    }
    
    struct StyledButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14.0)
                .background(isEnabled ? Color.green : Color.init(#colorLiteral(red: 0.8822754025, green: 0.8824025393, blue: 0.8822476268, alpha: 1)))
                .foregroundColor(isEnabled ? .white : Color.init(#colorLiteral(red: 0.705819428, green: 0.7059226632, blue: 0.7057968974, alpha: 1)))
                .overlay(configuration.isPressed ? Color.init(#colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 0.2047035531)) : Color.init(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0)))
                .cornerRadius(4.0)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
