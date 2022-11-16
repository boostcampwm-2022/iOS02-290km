//
//  FireStoreCollectionName.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

enum FireStoreCollection: String {
    case blocks, chatrooms, photographers, reservations, reviews, users
    
    var name: String {
        return self.rawValue
    }
}
