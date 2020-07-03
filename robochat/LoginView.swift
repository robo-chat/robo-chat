//
//  LoginView.swift
//  robochat
//
//  Created by 董超 on 2020/6/19.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

let DEFAULT_TITLE_PADDING_TOP: CGFloat = 52.0
let TITLE_WIDTH: CGFloat = 92.0

struct LoginView: View {
    @EnvironmentObject var appData: AppData
    
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var titlePaddingTop: CGFloat = DEFAULT_TITLE_PADDING_TOP
    
    private let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
    private let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
    
    var loginDisabled: Bool{
        get{
            userName.count == 0
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32.0){
            Button(action: close){
                Image(systemName: "xmark")
                    .font(.system(size: 18))
                    .padding(.vertical, 12)
            }.foregroundColor(Color(UIColor.label))
            Text("登录到机器人聊天室")
                .font(.title)
                .padding(.top, titlePaddingTop)
            VStack(spacing: 0.0) {
                HStack{
                    Text("帐号")
                        .multilineTextAlignment(.leading)
                        .frame(width: TITLE_WIDTH, alignment: .topLeading)
                    TextField("请填写汉字、英文字母或数字", text: $userName)
                }.padding(.vertical)
                Divider()
                HStack{
                    Text("密码")
                        .multilineTextAlignment(.leading)
                        .frame(width: TITLE_WIDTH, alignment: .topLeading)
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
            .background(Color("LoginBackgroundColor").edgesIgnoringSafeArea(.all))
            .onReceive(willShow){_ in
                withAnimation{
                    self.titlePaddingTop = 12.0
                }
            }
            .onReceive(willHide){_ in
                withAnimation{
                    self.titlePaddingTop = DEFAULT_TITLE_PADDING_TOP
                }
            }
    }
    
    private func login(){
        appData.userName = self.userName
        close()
    }
    
    private func close(){
        withAnimation(){
            appData.showLogin = false
        }
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
                .background(isEnabled ? Color.green : Color("LoginButtonDisabledColor"))
                .foregroundColor(isEnabled ? .white : Color("LoginButtonLabelDisabledColor"))
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
