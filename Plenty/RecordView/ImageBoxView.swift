//
//  ImageBoxView.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import SnapKit

class ImageBoxView: UIView {
    
    private let titleImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "cloverImage")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.text = "사진을 업로드하면 플랜티가 음식사진, 식품성분표, 영수증을 영양 성분 통계로 바꿔줘요"
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.numberOfLines = 3
        view.textAlignment = NSTextAlignment.center
        view.textColor = .white
        return view
    }()
    
    private lazy var cameraButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(named: "cameraButtonImage"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside )
        return button
    }()
    
    private lazy var imageButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(named: "imageButtonImage"), for: .normal)
//        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    @objc func cameraButtonTapped() {
        print("카메라 버튼 클릭")
        if cameraButton.isSelected == true {
            cameraButton.isSelected = false
        }
        else {
            cameraButton.isSelected = true
        }
    }
    
    @objc func imageButtonTapped() {
        print("이미지 버튼 클릭")
    }
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            titleImage,
            titleLabel
//            cameraButton,
//            imageButton
        ])
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        
        vStackView.backgroundColor = UIColor(hex: "#AADAE4")
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(67)
            make.bottom.equalToSuperview().offset(29)
            make.centerX.equalToSuperview()
        }
        
        titleImage.snp.makeConstraints { make in
            make.width.equalTo(69)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(279)
            make.height.equalTo(75)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.width.equalTo(353)
            make.height.equalTo(180)
        }
        
        imageButton.snp.makeConstraints { make in
            make.width.equalTo(353)
            make.height.equalTo(180)
        }
    }
}
