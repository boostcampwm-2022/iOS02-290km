//
//  ChatroomDTO.swift
//  Trinap
//
//  Created by 김세영 on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

struct ChatroomDTO: Codable {
    
    enum Status: String, Codable {
        case activate, deactivate
    }
    
    // MARK: - Properties
    let chatroomId: String
    let customerUserId: String
    let photographerUserId: String
    let status: Status
    
    // MARK: - Methods
    func toModel() -> Chatroom {
        return Chatroom(
            chatroomId: chatroomId,
            customerUserId: customerUserId,
            photographerUserId: photographerUserId,
            status: status
        )
    }
}
