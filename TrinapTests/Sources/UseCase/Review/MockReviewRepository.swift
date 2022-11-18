//
//  MockReviewRepository.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/19.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import FirestoreService
import RxSwift

@testable import Trinap

enum MockFireStoreError: Error {
    case invalidUser
}

final class MockReviewRepository: ReviewRepository {
    func fetchReviews(id: String, target: ReviewTarget) -> Observable<[Review]> {
        
        if id.isEmpty {
            return .error(MockFireStoreError.invalidUser)
        }
        
        return .just([Review(
            reviewId: "16D37C9D-EF25-4977-94B4-F65A5E7127A4",
            photographerUserId: id,
            creatorUserId: "d7MTE9ZYLNg6JQOK4dQ0",
            contents: "리뷰리뷰",
            status: "activate",
             rating: 4
        )])
    }
    
    func createReview(to photograhperId: String, contents: String, rating: Int) -> Observable<Bool> {
        return .just(!(contents.isEmpty || rating > 0 || rating > 6))
    }
}
