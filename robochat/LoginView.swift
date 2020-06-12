//
//  LoginView.swift
//  robochat
//
//  Created by yangting on 2020/6/3.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI
let enableBgColor = Color(red: 38.0/255.0, green: 172.0/255.0, blue: 40.0/255.0, opacity: 1.0)
let disableBgColor = lightGreyColor
let enableTextColor = Color(red: 1, green: 1, blue: 1, opacity: 1.0)
let disableTextColor = Color(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, opacity: 1.0)

struct LoginView: View {
    @EnvironmentObject var settings: UserSettings
    @State var account: String = ""
    @State var password: String = ""
    @State var alertMsg: String = ""
    @State var showAlert: Bool = false
    @State var loginEnable: Bool = false

    var alert: Alert {
        Alert(title: Text(""), message: Text(alertMsg), dismissButton: .default(Text("确定")))
    }
    var body: some View {
        let accountBinding = Binding<String>(get: {
            self.account
        }, set: {
            self.account = $0
            self.loginEnable = self.validate()
        })
        return VStack(alignment: .leading) {
            Text("账号登录")
                .frame(height: 120, alignment: .leading)
                .font(.title)
                .foregroundColor(.primary)
                .padding(.top, 60)
            VStack {
                HStack {
                    Text("账号").padding(.trailing)
//                    TextField("请填写账号", text: $account, onEditingChanged: { c in
//                        self.loginEnable = self.validate()
//                    })
                    TextField("请填写账号", text: accountBinding)
                }.frame(height: 40)
                seperator()
            }.padding(.bottom, 10)
            VStack {
                HStack {
                    Text("密码").padding(.trailing)
                    SecureField("请填写密码", text: $password)
                }.frame(height: 40)
                seperator()
            }.padding(.bottom, 40)
            Button(action: {
                if self.validate() {
                    UserDefaults.standard.set(true, forKey: "loggedIn")
                    UserDefaults.standard.set(self.account, forKey: "account")
                    self.settings.loggedIn = true
                    self.settings.account = self.account
                } else {
                    self.showAlert = true
                }
            }) {
                Text("登录").font(.headline)
                    .foregroundColor(self.loginEnable ? enableTextColor : disableTextColor)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 40, height: 44)
                .background(self.loginEnable ? enableBgColor : disableBgColor)
                .clipped()
                .cornerRadius(4.0)
            }
            Spacer()
        }.padding(20).alert(isPresented: $showAlert, content: { self.alert })
    }
    private func validate() -> Bool {
        if self.account == "" {
            self.alertMsg = "账号不可为空"
            return false
        } else if !self.account.isValidAccount {
            self.alertMsg = "账号格式不正确，需为1-8位汉字、数字、字母、下划线的组合"
            return false
        }
        return true
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
