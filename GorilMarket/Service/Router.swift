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
     case sepettekiYemekleriGetir
     case sepeteYemekEkle(yemekId: Int)
     case sepettenYemekSil(yemekId: Int)
     case yemekResmiGetir(resimAdi: String)
 }

 extension Router: URLRequestConvertible {
    
     static let baseURL = "https://kasimadalan.pe.hu/yemekler"
     
     var url: URL {
         switch self {
         case .tumYemekleriGetir:
             return URL(string: Router.baseURL + "/tumYemekleriGetir.php")!
         case .sepettekiYemekleriGetir:
             return URL(string: Router.baseURL + "/sepettekiYemekleriGetir.php")!
         case .sepeteYemekEkle(let yemekId):
             return URL(string: Router.baseURL + "/sepeteYemekEkle.php?yemekId=\(yemekId)")!
         case .sepettenYemekSil(let yemekId):
             return URL(string: Router.baseURL + "/sepettenYemekSil.php?yemekId=\(yemekId)")!
         case .yemekResmiGetir(let resimAdi):
             return URL(string: Router.baseURL + "/resimler/\(resimAdi)")!
         }
     }
     
     var method: HTTPMethod {
         switch self {
         case .tumYemekleriGetir, .sepettekiYemekleriGetir, .yemekResmiGetir:
             return .get
         case .sepeteYemekEkle, .sepettenYemekSil:
             return .post
         }
     }
     
     var parameters: [String : Any]? {
         switch self {
         case .tumYemekleriGetir, .sepettekiYemekleriGetir, .yemekResmiGetir:
             return [:]
         case .sepeteYemekEkle(let yemekId):
             return ["yemekId": yemekId]
         case .sepettenYemekSil(let yemekId):
             return ["yemekId": yemekId]
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
