//
//  PopUpViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/26/23.
//

import UIKit
import SnapKit

class PopUpViewController: UIViewController {
    
    private let titleTextView: UILabel = {
        let view = UILabel()
        var temp = [String]()
        
        if nowModel.Foods == temp {
            view.text = "음식이 아닙니다"
        }
        else {
            view.text = String(describing: nowModel.Foods!)
        }
        
        view.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        view.numberOfLines = 3
        view.textColor = UIColor(hex: "#5F97FF")
        return view
    }()

    
    private let nutrientImageView: UILabel = {
        let view = UILabel()
        view.text = "영양소"
        view.textColor = .white
        view.backgroundColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    private let eatImageView: UILabel = {
        let view = UILabel()
        view.text = "섭취량"
        view.textColor = .white
        view.backgroundColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.clipsToBounds = true
        return view
    }()
    
    private let intakeImageView: UILabel = {
        let view = UILabel()
        view.text = "섭취율"
        view.textColor = .white
        view.backgroundColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.clipsToBounds = true
        return view
    }()
    
    //에너지
    private let energyView: UILabel = {
        let view = UILabel()
        view.text = "에너지(kcal)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //탄수화물
    private let carbohydrateView: UILabel = {
        let view = UILabel()
        view.text = "탄수화물(g)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //단백질
    private let proteinView: UILabel = {
        let view = UILabel()
        view.text = "단백질(g)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    //지방
    private let provinceView: UILabel = {
        let view = UILabel()
        view.text = "지방(g)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //콜레스테롤
    private let cholesterolView: UILabel = {
        let view = UILabel()
        view.text = "콜레스테롤(mg)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    //식이섬유
    private let dietaryFiberVIew: UILabel = {
        let view = UILabel()
        view.text = "식이섬유(g)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //나트륨
    private let sodiumView: UILabel = {
        let view = UILabel()
        view.text = "나트륨(mg)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    //칼륨
    private let potassiumView: UILabel = {
        let view = UILabel()
        view.text = "칼륨(mg)"
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nutrientStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            energyView,
            carbohydrateView,
            proteinView,
            provinceView,
            cholesterolView,
            dietaryFiberVIew,
            sodiumView,
            potassiumView
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    
    //에너지
    private let energyCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Energy!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //탄수화물
    private let carbohydrateCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Carbohydrate!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //단백질
    private let proteinCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Protein!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    //지방
    private let provinceCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Province!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //콜레스테롤
    private let cholesterolCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Cholesterol!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    //식이섬유
    private let dietaryFiberCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.DietaryFiber!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    //나트륨
    private let sodiumCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Sodium!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    //칼륨
    private let potassiumCount: UILabel = {
        let view = UILabel()
        view.text = String(describing: nowModel.Potassium!)
        view.textColor = .black
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nutrientStackCount: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            energyCount,
            carbohydrateCount,
            proteinCount,
            provinceCount,
            cholesterolCount,
            dietaryFiberCount,
            sodiumCount,
            potassiumCount
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    
    private let whiteBox: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 300, height: 500)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var footerButton: UIButton = {
        let button = UIButton()
        button.setTitle("측정 완료하였습니다", for: .normal)
        button.backgroundColor = UIColor(hex: "#5F97FF")
        button.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside )
        return button
    }()
    
    @objc private func cameraButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(whiteBox)
        view.addSubview(footerButton)
        whiteBox.addSubview(titleTextView)
        whiteBox.addSubview(nutrientStackView)
        whiteBox.addSubview(nutrientStackCount)
        
        whiteBox.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        titleTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(45)
            make.width.equalToSuperview()
        }
        
        nutrientStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
        }
        
        nutrientStackCount.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(nutrientStackView.snp.trailing).offset(80)
        }
        
        footerButton.snp.makeConstraints { make in
            //            make.top.equalTo(totalView.snp.bottom).offset(17)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        super.viewDidLoad()
        layout()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "영양 분석"
    }
}
