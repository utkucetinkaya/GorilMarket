//
//  NetworkService.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 14.10.2023.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request<T: Decodable>(_ router: Router,Type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

class AlamofireNetworkService: NetworkService {

    static let shared = AlamofireNetworkService()
    private init() {}

    func request<T: Decodable>(_ router: Router, Type type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        var request = router.request()

        // Add parameters to the request body
        if let parameters = router.parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }

        // Make the network request
        AF.request(request).responseDecodable(of: T.self, completionHandler: { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
