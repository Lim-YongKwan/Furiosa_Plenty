//
//  AnalyzeViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import SnapKit

class AnalyzeViewController: UIViewController {
    private var apiHandler = ProductsURL()
    
    private let safeAreaVIew: UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    @objc func cameraButtonTapped() {
        print("저장하기 버튼 클릭")
        
        let imageData = Data(analzyeImage.pngData()!)
        
        apiHandler.postProductsURLs(intNum: giftLable.text ?? "0", imageData: imageData) { result in
            print("result 값 : \(result)")
            let vc = PopUpViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        let vc = PopUpViewController()
//        navigationController?.pushViewController(vc, animated: true)
//        navigationController?.popToRootViewController(animated: true)
    }
    let myUIStepper = UIStepper()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hex: "#AADAE4")
        super.viewDidLoad()
        
        // Resume UIStepper value from the beginning
        myUIStepper.wraps = false
        // Position UIStepper in the center of the view
        myUIStepper.center = self.view.center
        // If tap and hold the button, UIStepper value will continuously increment
        myUIStepper.autorepeat = true
        // Set UIStepper max value to 10
        myUIStepper.maximumValue = 10
        // Add a function handler to be called when UIStepper value changes
        myUIStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        setupNavigation()
        configureCustomView()
        layout()
    }
    
    private func configureCustomView() {
        var bomttomSafeAreaInsets: CGFloat = 0.0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let hasWindowScene = windowScene {
            bomttomSafeAreaInsets = hasWindowScene.windows.first?.safeAreaInsets.bottom ?? 0
        }
        
        // bomttomSafeAreaInsets 변수에는 하단 Safe Area의 크기가 할당된다.
        self.safeAreaVIew.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.safeAreaVIew)
        
        self.safeAreaVIew.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.safeAreaVIew.topAnchor.constraint(equalTo: view.topAnchor),
            self.safeAreaVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.safeAreaVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.safeAreaVIew.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "영양 분석"
    }
    
    private func layout() {
        view.addSubview(titleImage)
        view.addSubview(totalView)
        view.addSubview(footerButton)
        totalView.addSubview(myUIStepper)
        totalView.addSubview(giftLable)
        totalView.addSubview(personTextLabel)
        
        titleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.height.equalTo(404)
            make.width.equalTo(363)
        }
        
        totalView.snp.makeConstraints { make in
            make.top.equalTo(titleImage.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(195)
            make.width.equalTo(300)
        }
        
        footerButton.snp.makeConstraints { make in
            //            make.top.equalTo(totalView.snp.bottom).offset(17)
            make.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
        
        personTextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(totalView.snp.top).offset(23)
        }
        
        giftLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(personTextLabel.snp.bottom).offset(5)
        }
        
        myUIStepper.snp.makeConstraints { make in
            make.top.equalTo(giftLable.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}
