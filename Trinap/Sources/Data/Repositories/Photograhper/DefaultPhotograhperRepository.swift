//
//  DefaultPhotograhperRepository.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/16.
//  Copyright © 2022 Trinap. All rights reserved.
//

import Foundation

import RxSwift

final class DefaultPhotographerRepository: PhotographerRepository {
    
    private let firebaseStoreService: FireStoreService
    
    init(firebaseStoreService: FireStoreService) {
        self.firebaseStoreService = firebaseStoreService
    }
    
    func fetchPhotographers(type: TagType) -> Observable<[Photograhper]> {
        
        return firebaseStoreService.getDocument(collection: .photographers)
            .map { $0.compactMap { $0.toObject(type: PhotographerDTO.self)?.toModel() } }
            .asObservable()
    }
    
    func fetchDetailPhotographer(of photograhperId: String) -> Observable<Photograhper> {
        
        return firebaseStoreService.getDocument(
            collection: .photographers,
            document: photograhperId
        )
        .compactMap { $0.toObject(type: PhotographerDTO.self)?.toModel() }
        .asObservable()
    }
    
    func create(photographer: Photograhper) -> Observable<Void> {
        let dto = PhotographerDTO(
            photograhper: photographer,
            status: .activate
        )
        guard let value = dto.asDictionary else { return .error(LocalError.structToDictionaryError) }
        return firebaseStoreService.createDocument(
            collection: .photographers,
            document: photographer.photograhperId,
            values: value)
            .asObservable()
    }
    
    func updatePhotograhperInformation(with information: Photograhper) -> Observable<Void> {
        
        let values = PhotographerDTO(photograhper: information, status: .activate)
        
        guard let data = values.asDictionary else {
            return .error(FireStoreError.unknown)
        }
        
        return firebaseStoreService.updateDocument(
            collection: .photographers,
            document: information.photograhperId,
            values: data
        )
        .asObservable()
    }
    
    func updatePortfolioPictures(photograhperId: String, with images: [String], image: Data) -> Observable<Void> {
        
        var updateImages = images
        
        return firebaseStoreService.uploadImage(imageData: image)
            .asObservable()
            .withUnretained(self)
            .flatMap { owner, url in
                updateImages.append(url)
                let values = ["pictures": updateImages]
                return owner.firebaseStoreService.updateDocument(
                    collection: .photographers,
                    document: photograhperId,
                    values: values
                )
            }
    }
}
