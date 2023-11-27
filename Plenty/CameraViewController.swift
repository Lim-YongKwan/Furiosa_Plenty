//
//  CameraViewController.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController {
    private var apiHandler = ProductsURL()
    
    private let safeAreaVIew: UIView = {
        let view = UIView()
        return view
    }()
    
    private let previewView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Capture Session
    private var session: AVCaptureSession!
    // Photo Output
    private let output = AVCapturePhotoOutput()
    // Video Preview
    private var previewLayer = AVCaptureVideoPreviewLayer()
    //Shutter button
    
    private let alertImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "alertImage")
        view.frame = CGRect(x: view.frame.size.width / 2, y: view.frame.size.width / 2, width: 334, height: 40)
        view.contentMode = .scaleAspectFit
        view.animationDuration = 5.0
        return view
    }()
    
    private let shutterButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.cornerRadius = 30
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        
        let titleAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)
        ]
        self.navigationController?.navigationBar.titleTextAttributes = titleAttributes
        
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(alertImageView)
        view.addSubview(shutterButton)
        configureCustomView()
        checkCameraPermissions()
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        alertImageView.layer.position = CGPoint(x: view.frame.size.width / 2, y: 124)
        shutterButton.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 100)
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
    
    private let backBarItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "영양 분석", style: .plain, target: self, action: #selector(cameraButtonTapped))
        return button
    }()
    
    @objc private func cameraButtonTapped() {
        print("영양 분석 클릭")
        let vc = AnalyzeViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "사진 촬영"
        navigationItem.rightBarButtonItem = backBarItem
    }
    
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // Request
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    private func setUpLivePreview() {
        // 캡처 비디오를 표시할 레이어
        
        previewLayer.videoGravity = .resizeAspect
        //        videoPreviewLayer?.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(previewLayer)
        
        // startRunning이 blocking call이므로 GCD 사용
        DispatchQueue.global(qos: .userInitiated).async {
            // 세션 시작
            self.session.startRunning()
            
            // UI 변경을 위해 main queue 접근
            DispatchQueue.main.async {
                self.previewLayer.frame = self.previewView.bounds
            }
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                DispatchQueue.global(qos: .userInitiated).async {
                    // 세션 시작
                    session.startRunning()
                    
                    // UI 변경을 위해 main queue 접근
                    DispatchQueue.main.async {
                        self.previewLayer.frame = self.previewView.bounds
                    }
                }
                self.session = session
            }
            catch {
                print(error)
            }
        }
    }
    
    
    @objc private func didTapTakePhoto() {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
    }
    
    private func addBackgroundFrostToButton(_ backgroundBlur: UIVisualEffectView, vibrancy: UIVisualEffectView, button: UIButton, width: CGFloat?, height: CGFloat?){

        backgroundBlur.frame = button.bounds
        vibrancy.frame = button.bounds
        backgroundBlur.contentView.addSubview(vibrancy)
        button.insertSubview(backgroundBlur, at: 0)

        if let width = width {
            backgroundBlur.frame.size.width += width
        }

        if let height = height {
            backgroundBlur.frame.size.height += height
        }

        backgroundBlur.center = CGPoint(x: button.bounds.midX, y: button.bounds.midY)
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else {
            return
        }
        
        analzyeImage = UIImage(data: data) ?? UIImage(named: "cameraButtonImage")!
        todayImage.append(analzyeImage)

        let vc = AnalyzeViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
//        session?.stopRunning()
    }
}
