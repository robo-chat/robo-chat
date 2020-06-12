//
//  ChatView.swift
//  robochat
//
//  Created by yangting on 2020/6/11.
//  Copyright © 2020 robochat. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var settings: UserSettings
    var body: some View {
        Text("Hello \(self.settings.account)!")
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
