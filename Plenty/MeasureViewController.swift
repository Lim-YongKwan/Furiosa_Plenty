//
//  MeasureViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import SnapKit

class MeasureViewController: UIViewController {
    private var apiHandler = ProductsURL()
    
    private let safeAreaVIew: UIView = {
        let view = UIView()
        return view
    }()
    
    private let textLabel: UILabel = {
        let view = UILabel()
        view.text = "권장량 대비 섭취량"
        view.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        view.textColor = UIColor(hex: "#5F97FF")
        return view
    }()
    
    private let carbohydrateImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "carbohydrateImage")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let carbohydrateLabel: UILabel = {
        let view = UILabel()
        view.text = "탄수화물"
        view.textColor = .white
        view.backgroundColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    private let carbohydrateText: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.text = "167.5%"
        return view
    }()
    
    private lazy var carbohydrateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            carbohydrateImage,
            carbohydrateLabel,
            carbohydrateText
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    
    private let proteinImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "carbohydrateImage")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let proteinLabel: UILabel = {
        let view = UILabel()
        view.text = "단백질"
        view.textColor = .white
        view.backgroundColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    private let proteinText: UILabel = {
        let view = UILabel()
        view.textColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.text = "66%"
        return view
    }()
    
    private lazy var proteinStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            proteinImage,
            proteinLabel,
            proteinText
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let provinceImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "carbohydrateImage")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let provinceLabel: UILabel = {
        let view = UILabel()
        view.text = "지방"
        view.textColor = .white
        view.backgroundColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    private let provinceText: UILabel = {
        let view = UILabel()
        view.text = "41%"
        view.textColor = UIColor(hex: "#5F97FF")
        view.textAlignment = .center
        return view
    }()
    
    private lazy var provinceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            provinceImage,
            provinceLabel,
            provinceText
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            carbohydrateStackView,
            proteinStackView,
            provinceStackView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 31.5
        return stackView
    }()
    
    private lazy var intakeStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            textLabel,
            hStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 17
        return stackView
    }()
    
    private let totalView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 5
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let lackZeroText: UILabel = {
        let view = UILabel()
        view.text = "섭취 부족 영양소"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private let lackOneText: UILabel = {
        let view = UILabel()
        view.text = "단백질"
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.textAlignment = .center
        view.backgroundColor = .white
        view.textColor = .blue
        return view
    }()
    
    private let lackTwoText: UILabel = {
        let view = UILabel()
        view.text = "식이섬유"
        view.clipsToBounds = true
        view.textAlignment = .center
        view.layer.cornerRadius = 13
        view.backgroundColor = .white
        view.textColor = .blue
        return view
    }()
    
    private lazy var lackStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            lackZeroText,
            lackOneText,
            lackTwoText
        ])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let lackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#5F97FF")
        return view
    }()

    private let exceedZeroText: UILabel = {
        let view = UILabel()
        view.text = "섭취 초과 영양소"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return view
    }()
    
    private let exceedOneText: UILabel = {
        let view = UILabel()
        view.text = "나트륨"
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.backgroundColor = .white
        view.textColor = .blue
        return view
    }()
    
    private let exceedTwoText: UILabel = {
        let view = UILabel()
        view.text = "식이섬유"
        view.textAlignment = .center
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        view.backgroundColor = .white
        view.textColor = .blue
        return view
    }()
    
    private let detailImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "DetailNutrient")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var exceedStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            exceedZeroText,
            exceedOneText,
            exceedTwoText
        ])
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let exceedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#5F97FF")
        return view
    }()
    
//    private let nutrientDetailLabel: UILabel = {
//        let view = UILabel()
//        view.text = "섭취 영양소 상세"
//        view.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
//        view.textColor = UIColor(hex: "#5F97FF")
//        return view
//    }()
//    
//    private let nutrientTextLabel: UILabel = {
//        let view = UILabel()
//        view.text = "탄수화물"
//        view.textColor = .white
//        view.backgroundColor = UIColor(hex: "#5F97FF")
//        view.textAlignment = .center
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 13
//        return view
//    }()
//    
//    private let nutrientText: UILabel = {
//        let view = UILabel()
//        view.textColor = UIColor(hex: "#5F97FF")
//        view.textAlignment = .center
//        view.text = "칼로리"
//        return view
//    }()
//    
//    private lazy var nutrientStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [
//            nutrientTextLabel,
//            nutrientText
//        ])
//        stackView.axis = .vertical
//        stackView.spacing = 5
//        return stackView
//    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        
        
        segment.selectedSegmentTintColor = .clear
        
        // 배경 색 제거
        segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        // Segment 구분 라인 제거
        segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        segment.insertSegment(withTitle: "일간", at: 0, animated: true)
        segment.insertSegment(withTitle: "주간", at: 1, animated: true)
        segment.insertSegment(withTitle: "월간", at: 2, animated: true)
        
        segment.selectedSegmentIndex = 0
        
        // 선택 되어 있지 않을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
        ], for: .normal)
        
        // 선택 되었을때 폰트 및 폰트컬러
        segment.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
        
        segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
        
        segment.translatesAutoresizingMaskIntoConstraints = false
        return segment
    }()
    
    @objc private func changeUnderLinePosition() {
        let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
        let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        
        apiHandler.dailyURLs { result in
            print("result 값 : \(result)")
        }
        
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.leadingDistance.constant = leadingDistance
            self?.view.layoutIfNeeded()
        })
    }
    
    private lazy var underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // 움직일 underLineView의 leadingAnchor 따로 작성
    private lazy var leadingDistance: NSLayoutConstraint = {
        return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hex: "#AADAE4")
        super.viewDidLoad()
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        configure()
        configureCustomView()
        setupNavigation()
        layout()
    }
    
    private func configure() {
        view.addSubview(containerView)
        containerView.addSubview(segmentControl)
        containerView.addSubview(underLineView)
        containerView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 40),
            
            segmentControl.topAnchor.constraint(equalTo: containerView.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            segmentControl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            segmentControl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            underLineView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 5),
            leadingDistance,
            underLineView.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments))
        ])
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
        navigationItem.title = "<                           오늘                              >"
    }
    
    private func layout() {
        view.addSubview(totalView)
        view.addSubview(lackView)
        view.addSubview(exceedView)
        view.addSubview(detailImage)
        totalView.addSubview(intakeStackView)
        lackView.addSubview(lackStack)
        lackView.layer.cornerRadius = 20
        exceedView.addSubview(exceedStack)
        exceedView.layer.cornerRadius = 20
        
        carbohydrateLabel.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(80)
        }
        
        proteinLabel.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(80)
        }
        
        provinceLabel.snp.makeConstraints { make in
            make.height.equalTo(27)
            make.width.equalTo(80)
        }
        
        intakeStackView.snp.makeConstraints { make in
            make.height.equalTo(155)
            //            make.width.equalTo(240)
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        totalView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(170)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(195)
            make.width.equalTo(300)
        }
        
        lackView.snp.makeConstraints { make in
            make.height.equalTo(144)
            make.width.equalTo(177.5)
            make.top.equalTo(totalView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(16)
        }
        
        lackStack.snp.makeConstraints { make in
            make.top.equalTo(lackView.snp.top).offset(20)
//            make.bottom.equalTo(lackView.snp.bottom).offset(20)
            make.centerX.equalTo(lackView.snp.centerX)
        }
        
        lackOneText.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(88)
        }
        
        lackTwoText.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(88)
        }
        
        exceedView.snp.makeConstraints { make in
            make.height.equalTo(144)
            make.width.equalTo(177.5)
            make.top.equalTo(totalView.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        exceedStack.snp.makeConstraints { make in
            make.top.equalTo(lackView.snp.top).offset(20)
//            make.bottom.equalTo(lackView.snp.bottom).offset(20)
            make.centerX.equalTo(exceedView.snp.centerX)
        }
        
        exceedOneText.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(30)
        }
        exceedTwoText.snp.makeConstraints { make in
            make.width.equalTo(88)
            make.height.equalTo(30)
        }
        
        detailImage.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(600)
            make.top.equalTo(exceedView.snp.bottom).offset(-60)
            make.centerX.equalToSuperview()
        }
    }
}
