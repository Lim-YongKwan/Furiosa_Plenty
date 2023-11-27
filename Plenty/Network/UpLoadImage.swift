//
//  UpLoadImage.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import Alamofire

func uploadImage(image: UIImage) {
    // 서버의 엔드포인트 URL을 설정합니다.
    let apiUrl = "https://your-api-endpoint.com/upload"

    // 이미지를 Data로 변환합니다.
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
        print("Failed to convert image to data")
        return
    }

    // Alamofire를 사용하여 이미지를 업로드합니다.
    AF.upload(multipartFormData: { multipartFormData in
        // 이미지 데이터를 추가합니다. 'file'은 서버에서 사용할 파라미터 이름입니다.
        multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
        // 다른 필요한 파라미터가 있다면 여기에서 추가할 수 있습니다.
    }, to: apiUrl)
    .responseJSON { response in
        switch response.result {
        case .success(let value):
            print("Upload successful: \(value)")
            // 업로드 성공 시 처리할 작업을 추가할 수 있습니다.
        case .failure(let error):
            print("Error during upload: \(error)")
            // 업로드 실패 시 처리할 작업을 추가할 수 있습니다.
        }
    }
}
