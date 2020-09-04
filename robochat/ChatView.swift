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
    @FetchRequest(entity: ChatMsg.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ChatMsg.time, ascending: true)]) var messages: FetchedResults<ChatMsg>

    var friendName = "机器人"
    let bottomId = UUID()
    let model = ApiClassifier()
    @State var inputContent = ""
    @State var useVoiceInput = false
    @State var showEmoji = false
    @State var showTools = false
    
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
                    ForEach(messages) {it in
                        if it.isMine {
                            msgMine(chatMsg: it)
                        } else {
                            msgOther(chatMsg: it)
                        }
                    }
                }.padding()
                Spacer()
                HStack(){}.frame(height: 0).id(bottomId)
            }.onReceive(keyboardDidShow){ _ in
                withAnimation {
                    content.scrollTo(bottomId)
                }
            }
            .onAppear() {
                content.scrollTo(bottomId)
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
        let msg = ChatMsg(context: self.context)
        msg.id = UUID()
        msg.isMine = true
        msg.msg = inputContent
        msg.time = Date()
        do {
            try self.context.save()
            reply(inputContent)
        } catch {
            print(error.localizedDescription)
        }
        inputContent = ""
    }
    
    func reply(_ content: String) {
        guard let output = try? model.prediction(text: content) else {
            fatalError("Unexpected runtime error.")
        }
        let msg = ChatMsg(context: self.context)
        msg.id = UUID()
        msg.isMine = false
        msg.msg = output.label.replacingOccurrences(of: "_", with: "/")
        msg.time = Date()
        do {
            try self.context.save()
        } catch {
            print(error.localizedDescription)
        }
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
//        ChatView()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ChatView().environment(\.managedObjectContext, context)
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
