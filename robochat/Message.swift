//
//  MessageModel.swift
//  robochat
//
//  Created by 董超 on 2020/8/6.
//  Copyright © 2020 robochat. All rights reserved.
//
import SwiftUI

struct Message: Identifiable {
    let id: UUID = UUID()
    let content: String //TODO: 支持更多类型
    let isMe: Bool
}
