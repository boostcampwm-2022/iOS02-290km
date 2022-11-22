//
//  FetchUserUseCase.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/21.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

protocol FetchUserUseCase {
    func fetchUserInfo() -> Observable<User>
}
