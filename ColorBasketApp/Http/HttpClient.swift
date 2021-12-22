//
//  HttpClient.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/28.
//

import Foundation

class HttpClient {
    let baseUrl: String = BASEURL
    
    func getJson(completed: @escaping (Result<String, Error>) -> Void){DispatchQueue.global(qos: .background).async {
        do {
            let url: URL = URL(string: self.baseUrl)!
            let json = try String(contentsOf: url, encoding: .utf8)
            DispatchQueue.main.async {
                completed(Result.success(json))
            }
        } catch {
            DispatchQueue.main.async {
                completed(Result.failure(error))
            }
        }
    }}
}
