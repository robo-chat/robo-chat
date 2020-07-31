//
//  ChatView.swift
//  robochat
//
//  Created by yangting on 2020/7/10.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var appData: AppData
    @State private var msg: String = ""
    @State private var micType: Bool = false
    @State private var cusKeyboradType: Bool = false
    @State private var bottom: CGFloat = 0
    private let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
    private let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
    var body: some View {
        GeometryReader {geometry in
            VStack{
                Spacer()
                HStack {
                    Button(action: {
                        self.micType = !self.micType
                        if(self.micType) {
                            self.cusKeyboradType = false
                        }
                    }){
                        Image(systemName: self.micType ? "calendar.circle" : "mic.circle")
                            .font(.system(size: 25))
                            .foregroundColor(.primary)
                    }
                    if(self.micType) {
                        HStack {
                            Spacer()
                            Text("按住 说话")
                            Spacer()
                        }.frame(height: 40)
                            .background(Color("chat_send_text_background"))
                            .padding(.horizontal, 8)
                    } else {
                        TextField("", text: self.$msg)
                            .frame(height: 40)
                            .background(Color("chat_send_text_background"))
                    }
                    Button(action: {
                        self.cusKeyboradType = !self.cusKeyboradType
                        if(self.cusKeyboradType) {
                            self.micType = false
                        }
                    }){
                        Image(systemName: self.cusKeyboradType ? "calendar.circle" : "smiley")
                            .font(.system(size: 25))
                            .foregroundColor(.primary)
                    }
                    Image(systemName: "plus.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.primary)
                }.frame(height: 58)
                    .padding(.horizontal)
                    .background(Color("chat_send_background"))
            }.navigationBarTitle("智能助手", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: self.toLogin){
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    },
                    trailing: Button(action: self.toLogin){
                        Image(systemName: "ellipsis")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                )
                .padding(.bottom, self.bottom)
                .onReceive(self.willShow){note in
                    withAnimation{
                        self.bottomChange(note, geometry: geometry)
                    }
                }
                .onReceive(self.willHide){note in
                    self.bottomChange(note, geometry: geometry)
                }
        }
    }
    private func toLogin(){
        withAnimation{
            appData.showLogin = true
        }
    }
    private func bottomChange(_ notification: Notification, geometry: GeometryProxy) {
        let space = geometry.safeAreaInsets.bottom
        let userInfo = notification.userInfo;
        let keyboardBeginFrame = userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect
        let keyboardEndFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let visible = keyboardBeginFrame?.minY ?? 0 > keyboardEndFrame?.minY ?? 0
        self.bottom = visible ? (keyboardEndFrame?.height ?? 0) - space : 0
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
