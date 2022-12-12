//
//  EditPhotographerProfileHeaderView.swift
//  Trinap
//
//  Created by Doyun Park on 2022/11/24.
//  Copyright © 2022 Trinap. All rights reserved.
//

import UIKit

import RxSwift

final class EditPhotographerProfileCell: BaseCollectionViewCell {
    
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, TagType>
    
    lazy var filterView = FilterView(filterMode: .photographer)
    private lazy var profileImage = ProfileImageView()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: TagCollectionViewLeftAlignFlowLayout(offset: trinapOffset, direction: .horizontal)).than {
        $0.backgroundColor = TrinapAsset.white.color
    }
    
    private var dataSource: DataSource?
    
    private lazy var nickNameLabel = UILabel().than {
        $0.text = "어디로든떠나요"
        $0.textColor = .black
        $0.font = TrinapFontFamily.Pretendard.bold.font(size: 20)
    }
     
    private lazy var locationLabel = UILabel().than {
        $0.text = "서울시 성동구"
        $0.textColor = TrinapAsset.gray40.color
        $0.font = TrinapFontFamily.Pretendard.regular.font(size: 14)
    }
    
    lazy var editButton = TrinapButton(style: .black, fillType: .border, isCircle: true).than {
        $0.setTitle("작가정보 수정", for: .normal)
        $0.titleLabel?.font = TrinapFontFamily.Pretendard.regular.font(size: 12)
    }
    
    private lazy var stackView = UIStackView()
    
    override func configureHierarchy() {
        self.addSubviews(
            [
                profileImage,
                nickNameLabel,
                locationLabel,
                editButton,
                collectionView,
                filterView
            ]
        )
    }
    
    override func configureConstraints() {
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(trinapOffset * 8)
            make.leading.equalToSuperview().inset(trinapOffset * 2)
            make.top.equalToSuperview().inset(trinapOffset * 3)
        }

        nickNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(trinapOffset * 2)
            make.top.equalTo(profileImage).offset(trinapOffset / 2)
        }

        locationLabel.snp.makeConstraints { make in
            make.leading.equalTo(nickNameLabel)
            make.top.equalTo(nickNameLabel.snp.bottom).offset(trinapOffset / 2)
        }

        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImage)
            make.trailing.equalToSuperview().inset(trinapOffset * 3)
            make.height.equalTo(trinapOffset * 4)
            make.width.equalTo(trinapOffset * 10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(trinapOffset * 2)
            make.trailing.equalToSuperview()
            make.top.equalTo(profileImage.snp.bottom).offset(trinapOffset)
            make.height.equalTo(trinapOffset * 3)
        }
        
        filterView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom)
            make.height.equalTo(trinapOffset * 6)
        }
    }
    
    override func configureAttributes() {
        self.configureCollectionView()
        self.generateDataSource()
    }
    
    func configure(with profile: PhotographerUser) {
        nickNameLabel.text = profile.nickname
        locationLabel.text = profile.location
        profileImage.setImage(at: profile.profileImage)
        
        let snapshot = generateSnapshot(tags: profile.tags)
        
        self.dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - collectionView
extension EditPhotographerProfileCell: UICollectionViewDelegateFlowLayout {
    
    private func configureCollectionView() {
        self.collectionView.register(TagCell.self)
        self.collectionView.allowsSelection = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delegate = self
    }
    
    private func generateDataSource() {
        self.dataSource = DataSource(collectionView: self.collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueCell(TagCell.self, for: indexPath) else {
                return UICollectionViewCell()
            }
            
            cell.configure(
                tag: itemIdentifier,
                backgroundColor: TrinapAsset.sub2.color,
                textColor: TrinapAsset.secondary.color,
                fontSize: 12
            )
            return cell
        }
    }
    
    private func generateSnapshot(tags: [TagType]) -> NSDiffableDataSourceSnapshot<Section, TagType> {
        var snapShot = NSDiffableDataSourceSnapshot<Section, TagType>()
        snapShot.appendSections([.main])
        snapShot.appendItems(tags, toSection: .main)
        return snapShot
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let text = dataSource?.itemIdentifier(for: indexPath)?.title else {
            return .zero
        }
        let width = "#\(text)".size(withAttributes: [NSAttributedString.Key.font: TrinapFontFamily.Pretendard.regular.font(size: 12)]).width + trinapOffset * 2
        
        return CGSize(width: width, height: trinapOffset * 3)
    }
}
