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
    @State private var cusKeyboradType = false
    var body: some View {
        VStack{
            Spacer()
            HStack {
                Button(action: {
                    self.micType = !self.micType
                    if(self.micType) {
                        self.cusKeyboradType = false
                    }
                }){
                    Image(systemName: micType ? "calendar.circle" : "mic.circle")
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
                    TextField("", text: $msg)
                        .frame(height: 40)
                        .background(Color("chat_send_text_background"))
                }
                Button(action: {
                    self.cusKeyboradType = !self.cusKeyboradType
                    if(self.cusKeyboradType) {
                        self.micType = false
                    }
                }){
                    Image(systemName: cusKeyboradType ? "calendar.circle" : "smiley")
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
            leading: Button(action: toLogin){
                Image(systemName: "chevron.left")
                .font(.system(size: 20))
                .foregroundColor(.primary)
            },
            trailing: Button(action: toLogin){
                Image(systemName: "ellipsis")
                .font(.system(size: 20))
                .foregroundColor(.primary)
            }
        )
    }
    private func toLogin(){
        withAnimation{
            appData.showLogin = true
        }
    }
}
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
