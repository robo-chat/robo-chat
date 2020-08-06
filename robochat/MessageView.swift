//
//  MessageView.swift
//  robochat
//
//  Created by 董超 on 2020/8/5.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    let message: Message
    var contentBackgroundColor: Color{
        get{
            return Color(message.isMe ? "chat_me_background" : "chat_friend_background")
        }
    }
    
    var body: some View {
        let hDirection = message.isMe ? LayoutDirection.leftToRight : LayoutDirection.rightToLeft
        HStack(alignment: VerticalAlignment.top){
            Spacer()
            HStack(alignment: VerticalAlignment.top, spacing: 0){
                Spacer()
                
                HStack{
                    Text(message.content)
                }.environment(\.layoutDirection, LayoutDirection.leftToRight)
                .padding(.all, 12)
                .background(contentBackgroundColor)
                .cornerRadius(5.0)
                
                RoundedRectangle(cornerRadius: 3.0)
                    .frame(width: 14, height: 14)
                    .rotationEffect(.init(degrees: 45), anchor: .center)
                    .offset(x: -9, y: 15)
                    .foregroundColor(contentBackgroundColor)
            }.frame(maxWidth: 300)
            .environment(\.layoutDirection, hDirection)
            
            Image(message.isMe ? "totoro-avatar" : "robot-avatar")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .cornerRadius(5.0)
            
        }
        .padding(.trailing, 12)
        .environment(\.layoutDirection, hDirection)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(content: "haha", isMe: true))
    }
}
