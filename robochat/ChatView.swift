//
//  ChatView.swift
//  robochat
//
//  Created by 董超 on 2020/7/22.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var context
//    @FetchRequest(entity: Message.entity(), sortDescriptors: []) var messages: FetchedResults<Message>

    var friendName = "机器人"
    @State var inputContent = ""
    @State var useVoiceInput = false
    @State var showEmoji = false
    @State var showTools = false
    @State var list = msgList
    
    private let keyboardWillShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
    private let keyboardDidShow = NotificationCenter.default.publisher(for: UIApplication.keyboardDidShowNotification)
    var body: some View {
        VStack(spacing: 0) {
            chatWindow
            VStack(){
                inputBar
                if showEmoji {
                    emojiBox.transition(.move(edge: .bottom))
                }
            }.background(Color("ChartInputBarBackgroundColor").edgesIgnoringSafeArea(.all))
        }.background(Color("InputBackgroundColor")
        .edgesIgnoringSafeArea(.all))
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
        ScrollViewReader {content in
            ScrollView(){
                LazyVStack(alignment: .leading) {
                    ForEach(list, id: \.id) {it in
                        if it.isMine {
                            msgMine(chatMsg: it)
                        } else {
                            msgOther(chatMsg: it)
                        }
                    }
                }.padding()
            }.onReceive(keyboardDidShow){ _ in
                withAnimation {
                    content.scrollTo(list.count)
                }
            }.onAppear() {
                content.scrollTo(list.count)
            }
        }
        .background(Color("ChatBackgroundColor"))
        .gesture(
            TapGesture()
                .onEnded { _ in
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        )
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
        list.append(ChatMsg(id: list.count + 1, isMine: true, msg: inputContent))
        inputContent = ""
//        ForEach(list) {it in
//            let msg = Message(context: self.context)
//            msg.id = UUID()
//            msg.isMine = it.isMine
//            msg.content = it.msg
//            self.context.save()
//        }
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

struct msgOther: View {
    let chatMsg: ChatMsg
    var body: some View {
        HStack(alignment: .top, spacing: 3) {
            Image("chat_send_voice")
            HStack(alignment: .top ,spacing: 0) {
                Image.init(systemName: "arrowtriangle.left.fill")
                    .foregroundColor(.white)
                    .padding(.top, 8)
                    .padding(.trailing, -5)
                Text(chatMsg.msg)
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .background(Color.white)
                    .cornerRadius(5)
            }
            Spacer()
        }.padding(.trailing, 28)
    }
}

struct msgMine: View {
    let chatMsg: ChatMsg
    var body: some View {
        HStack(alignment: .top, spacing: 3) {
            Spacer()
            HStack(alignment: .top ,spacing: 0) {
                Text(chatMsg.msg)
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .background(Color("chat_me_background"))
                    .cornerRadius(5)
                Image.init(systemName: "arrowtriangle.right.fill")
                    .foregroundColor(Color("chat_me_background"))
                    .padding(.top, 8)
                    .padding(.leading, -5)
            }
            Image("chat_send_emoji")
        }.padding(.leading, 28)
    }
}
struct ChatMsg: Hashable, Identifiable {
    var id: Int
    var isMine: Bool
    var msg: String
}

var msgList: [ChatMsg] = [
    ChatMsg(id: 1, isMine: false, msg: "请你给我画一只羊，好吗？"),
    ChatMsg(id: 2, isMine: true, msg: "啊！"),
    ChatMsg(id: 3, isMine: false, msg: "给我画一只羊……"),
    ChatMsg(id: 4, isMine: true, msg: "这是一只箱子，你要的羊就在里面。"),
    ChatMsg(id: 5, isMine: true, msg: "瞧！它睡着了…"),
    ChatMsg(id: 6, isMine: false, msg: "这正是我想要的，……你说这只羊需要很多草吗？"),
    ChatMsg(id: 7, isMine: false, msg: "我的星球非常小，小行星B612。"),
    ChatMsg(id: 8, isMine: false, msg: "羊吃小灌木，这是真的吗？我想叫我的羊去吃小猴面包树。"),
    ChatMsg(id: 9, isMine: true, msg: "好吧，如你所愿…"),
    ChatMsg(id: 10, isMine: false, msg: "羊会吃花吗？"),
    ChatMsg(id: 11, isMine: true, msg: "它碰到什么吃什么。有刺的也吃！算了吧，算了吧！我什么也不认为！我是随便回答你的。我可有正经事要做。"),
    ChatMsg(id: 12, isMine: false, msg: "正经事？"),
    ChatMsg(id: 13, isMine: false, msg: "如果有人爱上了在这亿万颗星星中独一无二的一株花，当他看着这些星星 的时候，这就足以使他感到幸福，但是如果羊吃掉了这朵花，对他来说，好象所有的星星一下 子全都熄灭了一样！这难道也不重要吗？！"),
    ChatMsg(id: 14, isMine: true, msg: "emm……你说得对…"),
]
