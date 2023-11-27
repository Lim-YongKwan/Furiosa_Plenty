//
//  MyPageViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//


import UIKit
import SnapKit

class MyPageViewController: UIViewController {

    
    private let safeAreaVIew: UIView = {
        let view = UIView()
        return view
    }()
    
    private let myImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "myImage")
        view.contentMode = .scaleAspectFill
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#9CC6FB")

        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes

        layout()
        setupNavigation()
        configureCustomView()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "마이페이지"
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
    
    private func layout(){
        view.addSubview(myImageView)
        
        myImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
