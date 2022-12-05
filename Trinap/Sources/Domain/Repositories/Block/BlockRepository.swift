//
//  ReportRepository.swift
//  Trinap
//
//  Created by kimchansoo on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

protocol BlockRepository {
    
    // MARK: Methods
    func blockUser(blockedUserId: String) -> Single<Void>
    func fetchBlockedUser() -> Single<[Block]>
}
