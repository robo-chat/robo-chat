//
//  ChatView.swift
//  robochat
//
//  Created by 董超 on 2020/7/22.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI
import CoreData

let emojiKeyboardHasShownEvent = Notification.Name("emoji-keyboard-will-show")

struct ChatView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var dbContext
    @EnvironmentObject var appData: AppData

    let friendName = "机器人"
    @State var inputContent = ""
    @State var useVoiceInput = false
    @State var showEmoji = false
    @State var showTools = false
    @State var msgIdToVisible: UUID?
    
    @FetchRequest(entity: Message.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Message.sendTime, ascending: true)
    ]) var chatList: FetchedResults<Message>
    
    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
    
    var body: some View {
        VStack(spacing: 0) {
            chatWindow
            VStack(){
                inputBar
                if showEmoji {
                    emojiBox.transition(.move(edge: .bottom))
                }
            }.background(Color("ChartInputBarBackgroundColor").edgesIgnoringSafeArea(.all))
        }.background(Color("InputBackgroundColor").edgesIgnoringSafeArea(.all))
        .navigationBarTitle(friendName, displayMode: .inline)
        .navigationBarItems(
            leading: Button(action: back){
                Image(systemName: "chevron.left")
            }.padding(.all, 8).foregroundColor(Color(UIColor.label)),
            trailing: Image(systemName: "ellipsis")
        )
        .navigationBarBackButtonHidden(true)
        .onReceive(keyboardWillShow){ _ in
            showEmoji = false
        }
    }
    
    var chatWindow: some View{
        ScrollViewReader { scrollProxy in
            ScrollView(){
                LazyVStack{
                    ForEach(chatList){m in
                        return MessageView(message: m).id(m.id)
                    }
                }.padding(.vertical, 12)
            }
            .onChange(of: msgIdToVisible){id in
                guard id != nil else {return}
                print(id!)
                withAnimation{
                    scrollProxy.scrollTo(msgIdToVisible)
                }
            }
            .onAppear{
                msgIdToVisible = chatList.last?.id
                scrollProxy.scrollTo(msgIdToVisible)
            }
            .onReceive(keyboardWillShow){ _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation{
                        scrollProxy.scrollTo(msgIdToVisible)
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: emojiKeyboardHasShownEvent)){ _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation{
                        scrollProxy.scrollTo(msgIdToVisible)
                    }
                }
            }
            .background(Color("ChatBackgroundColor"))
            .gesture(
                TapGesture().onEnded{ _ in self.dismissKeyboard()}
            )
        }
    }
    
    var inputBar: some View{
        HStack(){
            Button(action: toogleVoiceInput){
                Image("chat_send_voice")
                    .accentColor(.primary)
            }
            TextField("", text: $inputContent, onCommit: send)
                .frame(height: 38)
                .background(Color("InputBackgroundColor"))
                .cornerRadius(2.0)
            Button(action: toggleEmoji){
                Image("chat_send_emoji")
                    .accentColor(.primary)
            }
            Button(action: toggleTools){
                Image("chat_send_more")
                    .accentColor(.primary)
            }
            
            
        }.padding(.all, 12)
    }
    
    let emojiColumns: [GridItem] =
            [.init(.adaptive(minimum: 40, maximum: 50))]
    
    var emojiBox: some View{
        ZStack(alignment: .bottomTrailing){
            ScrollView {
                LazyVGrid(columns: emojiColumns, spacing: 16) {
                    ForEach(emojiList, id: \.self) { emoji in
                        Button (action:{appendInput(emoji)}) {
                            Text(emoji).font(.title)
                        }
                    }
                }.padding(.all, 16)
            }.frame(height: 200)
            HStack{
                Button(action: delBack){
                    Image(systemName: "delete.left")
                }
                .frame(width: 60, height: 40)
                .accentColor(.primary)
                .background(Color("ButtonBackgroundColor"))
                .cornerRadius(3.0)
                .disabled(inputContent.count == 0)
                Button(action: send){
                    Text("发送")
                }
                .frame(width: 60, height: 40)
                .accentColor(.white)
                .background(Color.green)
                .cornerRadius(3.0)
                .disabled(inputContent.count == 0)
            }.padding(.all, 16)
        }.frame(height: 200)
        
    }
    
    
    func back(){
        presentation.wrappedValue.dismiss()
    }
    
    func send(){
        appendMsg(inputContent, true)
        inputContent = ""
        let delay = Double.random(in: 0.5..<3.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            appendMsg(["好的", "嗯嗯", "没问题", "收到", "好嘞，您呐！"].randomElement()!, false)
        }
    }
    
    func appendMsg(_ content: String, _ isMe: Bool){
        let msg = Message(context: dbContext)
        msg.content = content
        msg.isMe = isMe
        msg.id = UUID()
        msg.sendTime = Date()
        do{
            try dbContext.save()
        }catch{
            print("发送失败")
        }
        msgIdToVisible = msg.id
    }
    
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func delBack(){
        if inputContent.count > 0 {
            inputContent.removeLast()
        }
    }
    
    func toogleVoiceInput(){
        withAnimation(){
            useVoiceInput.toggle()
        }
    }
    
    func toggleEmoji(){
        if !showEmoji {
            dismissKeyboard()
        }
        withAnimation(){
            showEmoji.toggle()
        }
        if showEmoji {
            NotificationCenter.default.post(name: emojiKeyboardHasShownEvent, object: nil)
        }
    }
    
    func toggleTools(){
        withAnimation(){
            showTools.toggle()
        }
    }
    
    func appendInput(_ content: String){
        inputContent += content
    }

}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

var emojiList = "😀😂🤣😄😅😆😇😉😊🙂🙃☺️😋😌😍😘😙😜😝🤑🤓😎🤗🤡🤠😏😶😑😒🙄🤔😳😞😟😠😡😔😕☹️😣😖😫😤😮😱😨😰😯😦😢😥😪😓🤤😭😲🤥🤢🤧🤐😷🤒🤕😴💤💩😈👹👺💀👻👽🤖🤪🤨🧐🤩🤬🤯🤭🤫🤮🥴🥰🥳🥺".map{$0.description}

