//
//  CellData.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit


struct ServerData: Codable {
    var data: [JsonData]
    
    init(data: [JsonData]) {
        self.data = data
    }
    
    static let EMPTY = ServerData(data: [])
}

struct JsonData: Codable {
    let url: String
    let title: String?
    let color: [String]
    
    init(url: String, title: String?, color: [String]) {
        self.url = url
        self.title = title
        self.color = color
    }
    
    static let EMPTY = JsonData(url: "", title: "", color: [])
}
struct CellList {
    var data: [CellData]
    
    init(data: [CellData]) {
        self.data = data
    }
    
    static let EMPTY = CellList(data: [])
}

struct CellData {
    let image: UIImage
    let title: String?
    let color: [String]
    
    init(image: UIImage, title: String?, color: [String]) {
        self.image = image
        self.title = title
        self.color = color
    }
    
    static let EMPTY = CellData(image: UIImage(), title: "", color: [])
}
