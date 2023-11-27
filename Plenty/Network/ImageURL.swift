//
//  ImageURL.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import UIKit
import Alamofire

class ProductsURL {
    let api_key: String = Bundle.main.infoDictionary?["API_KEY"] as! String
    let photo = UIImage.init(named: "photo")
    
    //날짜, 갯수
    
    func postProductsURLs(intNum: String,imageData : Data, completion: @escaping (ProductsModel?) ->()){
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(imageData, withName: "file", fileName: "image", mimeType: "application/octet-stream")
            multipartFormData.append(Data("2023-11-26".utf8), withName: "date")
            multipartFormData.append(intNum.data(using: .utf8)!, withName: "num")
            
            guard let image = self.photo else { return }
            //            let jpegData = image.jpegData(compressionQuality: 1.0)
            ////            multipartFormData.append(Data((jpegData)!), withName: "photo")
            
        }, to: api_key)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("success : \(value)")
                guard let result = response.data else {return}
                print("result : \(result)")
                do {
                    let receivedData = try JSONDecoder().decode(ProductsModel?.self, from: result)
                    nowModel = receivedData!
                    completion(receivedData)
                } catch {
                    print("error!\(error)")
                }
            case .failure(let error):
                print("Error during upload: \(error)")
                // 업로드 실패 시 처리할 작업을 추가할 수 있습니다.
            }
        }
    }
    
    func getProductsURLs(_ page: Int, completion: @escaping (ProductsModel?) -> ()){
        
        let url = URL(string: api_key)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("error")
                return
            }
            if let data = data {
                do {
                    let receivedData = try JSONDecoder().decode(ProductsModel.self, from: data)
                    completion(receivedData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func dailyURLs(completion: @escaping (dailyModel?) -> ()) {
        
        let url = URL(string: api_key)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                print("error")
                return
            }
            if let data = data {
                do {
                    let receivedData = try JSONDecoder().decode(dailyModel.self, from: data)
                    weekModel = receivedData
                    completion(receivedData)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
