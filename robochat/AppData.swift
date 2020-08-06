//
//  AppData.swift
//  robochat
//
//  Created by 董超 on 2020/6/20.
//  Copyright © 2020 robochat. All rights reserved.
//

import Foundation

class AppData: ObservableObject{
    @Published var userName: String?
    @Published var showLogin: Bool = false
    @Published var chatList:[Message] = chatSamples.map{Message(content: $0, isMe: Bool.random())}
}
