//
//  Router.swift
//  GorilMarket
//
//  Created by Utku Çetinkaya on 14.10.2023.
//

import Foundation
import Alamofire

 protocol URLRequestConvertible {
     var url: URL { get }
     var method: HTTPMethod { get }
     var parameters: [String: Any]? { get }
     var headers: [String: String]? { get }
     func request() -> URLRequest
 }

enum Router {
    
    case tumYemekleriGetir
    case sepeteYemekEkle(name: String, imageName: String, price: Int, order: Int, username: String)
    case sepettekiYemekleriGetir(username: String)
    case sepettenYemekSil(cartID: String, username: String)
}

extension Router: URLRequestConvertible {
    
    var url: URL {
        switch self {
        case .tumYemekleriGetir:
            return URL(string: Constants.shared.baseURL + "/tumYemekleriGetir.php")!
        case .sepeteYemekEkle:
            return URL(string: Constants.shared.baseURL + "/sepeteYemekEkle.php")!
        case .sepettekiYemekleriGetir:
            return URL(string: Constants.shared.baseURL + "/sepettekiYemekleriGetir.php")!
        case .sepettenYemekSil:
            return URL(string: Constants.shared.baseURL + "/sepettenYemekSil.php")!
        }
    }
     
     var method: HTTPMethod {
         switch self {
         case .tumYemekleriGetir:
             return .get
         case .sepeteYemekEkle, .sepettekiYemekleriGetir, .sepettenYemekSil:
             return .post
         }
     }
     
    var parameters: [String : Any]? {
        switch self {
        case .tumYemekleriGetir:
            return nil
        case .sepeteYemekEkle(let name, let imageName, let price, let order, let username):
            return [
                "yemek_adi": name,
                "yemek_resim_adi": imageName,
                "yemek_fiyat": price,
                "yemek_siparis_adet": order,
                "kullanici_adi": username
            ]
        case .sepettekiYemekleriGetir(let username):
            return [
                "kullanici_adi": username
            ]
        case .sepettenYemekSil(let cartID, let username):
            return [
                "sepet_yemek_id": cartID,
                "kullanici_adi": username
            ]
        }
    }
     
     var headers: [String : String]? {
         return [:]
     }
     
     func request() -> URLRequest {
         // Create request
         var request = URLRequest(url: url)
         request.httpMethod = method.rawValue
         // Add Parameters
         if let parameters = parameters {
             do {
                 let data = try JSONSerialization.data(withJSONObject: parameters)
                 request.httpBody = data
             } catch {
                 print(error.localizedDescription)
             }
         }
         // Add Headers
         if let headers = headers {
             for (key, value) in headers {
                 request.setValue(value, forHTTPHeaderField: key)
             }
         }
         return request
     }
 }
