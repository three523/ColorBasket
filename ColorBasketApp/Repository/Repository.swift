//
//  Repository.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/28.
//

import Foundation
import UIKit

class Repository: NSObject {
    let httpClient: HttpClient = HttpClient()
    
    func ImageList(completed: @escaping ([JsonData]) -> Void) {
        httpClient.getJson { result in
            if let json = try? result.get() {
                completed(self.ImageGet(jsonObject: self.JSONObject(json)))
            }
        }
    }
    
    func JSONObject(_ json: String) -> [String:Any] {
        let data = json.data(using: .utf8)!
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        return jsonObject
    }
    
    func ImageGet(jsonObject: [String:Any]) -> [JsonData] {
        let json: [JsonData] = (jsonObject["data"] as! [[String:Any]]).map{ results in
            paserImage(jsonObject: results)
        }
        let cell: [CellData] = (jsonObject["data"] as! [[String:Any]]).map{ results in
            cellPaserImage(jsonObject: results)
        }
        return json
    }
    
    func paserImage(jsonObject: [String:Any]) -> JsonData {
        return JsonData(url: jsonObject["url"] as! String, title: jsonObject["title"] as? String, color: jsonObject["color"] as! [String])
    }
    func cellPaserImage(jsonObject: [String:Any]) -> CellData {
        let imageLoader = ImageLoader()
        var dataImage: UIImage = UIImage()
        guard let url = jsonObject["url"] as? String else {return CellData(image: UIImage(), title: "", color: [])}
        
        imageLoader.loadImage(url: url) { image in
            dataImage = image ?? UIImage()
        }
        return CellData(image: dataImage, title: jsonObject["title"] as? String, color: jsonObject["color"] as! [String])
    }
}
