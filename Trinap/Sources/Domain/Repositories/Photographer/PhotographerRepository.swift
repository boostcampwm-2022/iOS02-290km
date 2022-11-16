//
//  PhotographerRepository.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

protocol PhotographerRepository {
    func fetchPhotographers(type: TagType) -> Observable<[Photograhper]>
    func fetchDetailPhotographer(of photograhperId: String) -> Observable<Photograhper>
    func updatePhotograhperInformation(photograhperId: String, with information: Photograhper) -> Observable<Void>
    func updatePortfolioPictures(photograhperId: String, with images: [String], image: Data) -> Observable<Void>
}
