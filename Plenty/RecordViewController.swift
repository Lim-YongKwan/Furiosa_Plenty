//
//  RecordViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import SnapKit
import Alamofire

class RecordViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private var apiHandler = ProductsURL()
    
    private let imageBoxView = ImageBoxView()
    
    private let safeAreaVIew: UIView = {
        let view = UIView()
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
        button.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside )
        
        return button
    }()
    
    @objc private func cameraButtonTapped() {
        print("카메라 버튼 클릭")
        let vc = CameraViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageButtonTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageBoxView,
            cameraButton,
            imageButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(hex: "#AADAE4")
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        configureCustomView()
        setupNavigation()
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
        navigationItem.title = "<                           오늘                              >"
    }
    
    private func layout() {
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageBoxView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-67)
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
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photoLocalUrl = (info[UIImagePickerController.InfoKey.imageURL] as? URL)!
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            analzyeImage = image
            todayImage.append(analzyeImage)
            print("todayImage append : \(todayImage)")
            
            //다음 네비게이션으로 넘어가기.            
            //            apiHandler.getProductsURLs(0) { result in
            //                print("get 값 : \(result)")
            //            }
            
            
            let vc = AnalyzeViewController()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
        dismiss(animated: true, completion: nil)
    }
    
}

extension RecordViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("progress = ", Double(bytesSent) / Double(totalBytesSent))
    }
}
