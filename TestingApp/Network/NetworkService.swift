//
//  NetworkService.swift
//  TestingApp
//
//  Created by Лидия Пятаева on 02.07.2023.

import UIKit
import Alamofire
import SVProgressHUD

class NetworkService {
    
    private init() {}
    static let shared = NetworkService()
    
    public func requestCategory(completion: @escaping (Categories?, Error?) -> ()) {
        let url = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
        
        AF.request(url).responseData { (dataResponse) in
            if dataResponse.error != nil {
                completion(nil, dataResponse.error)
                print("error received requesting data")
                return
            }
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(Categories.self, from: data)
                completion(object, nil)
            } catch let jsonError {
                print("failed to deocode JSON, jsonError")
                print( jsonError.localizedDescription )
            }
        }
    }
    
    public func requestMenu(completion: @escaping (MenuModel?, Error?) -> ()) {
        let url = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
        
        AF.request(url).responseData { (dataResponse) in
            if dataResponse.error != nil {
                completion(nil, dataResponse.error)
                print("error received requesting data")
                return
            }
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            do {
                let object = try decoder.decode(MenuModel.self, from: data)
                completion(object, nil)
            } catch let jsonError {
                print("failed to deocode JSON, jsonError")
                print( jsonError.localizedDescription )
            }
        }
    }
}
