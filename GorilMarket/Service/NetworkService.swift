//
//  NetworkService.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 14.10.2023.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request<T: Decodable>(_ router: Router, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NetworkService {

    static let shared = NetworkManager()
    private init() {}

    func request<T: Decodable>(_ router: Router, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = router.request()
        
        // Add parameters to the request body
        if let parameters = router.parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                debugPrint(data)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }
        guard let url = request.url else { return }
        AF.request(url, method: .post, parameters: router.parameters).responseDecodable(of: T.self, completionHandler: { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        })

        // Make the network request
//        AF.request(request).responseDecodable(of: T.self, completionHandler: { response in
//            debugPrint("resr",response)
//            switch response.result {
//            case .success(let decodedData):
//                debugPrint("decodedData", decodedData)
//                completion(.success(decodedData))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        })
    }
}
