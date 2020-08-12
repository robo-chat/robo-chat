//
//  ChatMsg+CoreDataProperties.swift
//  robochat
//
//  Created by yangting on 2020/8/11.
//  Copyright © 2020 robochat. All rights reserved.
//
//

import Foundation
import CoreData


extension ChatMsg {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMsg> {
        return NSFetchRequest<ChatMsg>(entityName: "ChatMsg")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var msg: String
    @NSManaged public var isMine: Bool
    @NSManaged public var time: Date?

}

extension ChatMsg : Identifiable {

}
