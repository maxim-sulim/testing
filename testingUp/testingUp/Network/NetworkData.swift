//
//  NetworkData.swift
//  testingUp
//
//  Created by Максим Сулим on 30.06.2023.
//

import Foundation


class NetworkData {
    
    static let shared = NetworkData()
    
    private init() {}
    
    
    func workDataCategories(urlString: String, responce: @escaping (ResultsCategories?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(ResultsCategories.self, from: data)
                    responce(resultData,nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
        
    }
    
    func workDataDishes(urlString: String, responce: @escaping (ResultsDishes?, Error?) -> Void) {
        
        NetworkRequest.shared.request(stringUrl: urlString) { result in
            switch result {
            case .success(let data):
                do {
                    let resultData = try JSONDecoder().decode(ResultsDishes.self, from: data)
                    responce(resultData,nil)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
                responce(nil, error)
            }
        }
        
    }
}
