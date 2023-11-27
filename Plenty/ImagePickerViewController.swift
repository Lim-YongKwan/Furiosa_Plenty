//
//  AnalyzeViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import SnapKit

class LastViewController: UIViewController {

    private let titleImage: UIImageView = {
        let view = UIImageView()
        view.image = analzyeImage
        view.contentMode = .scaleToFill
        view.layer.borderWidth = 5
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private let personTextLabel: UILabel = {
        let view = UILabel()
        view.text = "몇인분인가요?"
        view.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        view.textColor = UIColor(hex: "#5F97FF")
        return view
    }()
    
    private var giftLable: UILabel = {
        var view = UILabel()
        view.text = "1"
        view.font = UIFont.systemFont(ofSize: 66, weight: .semibold)
        view.textColor = .black
        
        return view
    }()
    
    @objc func stepperValueChanged(_ sender:UIStepper!)
    {
        giftLable.text = Int(sender.value).description
    }
    
    private let totalView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var footerButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.backgroundColor = UIColor(hex: "#5F97FF")
        button.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside )
        return button
    }()
    
    @objc private func cameraButtonTapped() {
        print("저장하기 버튼 클릭")
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hex: "#AADAE4")
        super.viewDidLoad()
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        setupNavigation()
        layout()
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "영양 분석"
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(footerButton)
        
        footerButton.snp.makeConstraints { make in
            //            make.top.equalTo(totalView.snp.bottom).offset(17)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
    }
}
