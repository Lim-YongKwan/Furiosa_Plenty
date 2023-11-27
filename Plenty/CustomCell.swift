//
//  CustomCell.swift
//  Plenty
//
//  Created by 임 용관 on 11/26/23.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "salad"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.backgroundColor = UIColor(hex: "#50E1F0")
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        return label
    }()
    
    let calorieLabel: UILabel = {
        let label = UILabel()
        label.text = "330 kcal"
        label.clipsToBounds = true
        label.layer.cornerRadius = 15
        label.textColor = UIColor(hex: "#50E1F0")
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    var foodImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let servingText: UILabel = {
        let view = UILabel()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        view.text = "1.0 인분"
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.textColor = UIColor(hex: "#AADAE4")
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
        
        [foodImage].forEach {
            contentView.addSubview($0)
            foodImage.addSubview(servingText)
            foodImage.addSubview(nameLabel)
            foodImage.addSubview(calorieLabel)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.width.equalTo(85)
        }
        
        calorieLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(5)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(35)
            make.width.equalTo(85)
        }
        
        servingText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.trailing.equalToSuperview().offset(-10)
//            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(98)
        }
        
        foodImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(250)
            make.width.equalTo(363)
        }
        

    }
}
