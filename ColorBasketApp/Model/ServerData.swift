//
//  CellData.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit


struct ServerData: Codable {
    var data: [CellData]
    
    init(data: [CellData]) {
        self.data = data
    }
    
    static let EMPTY = ServerData(data: [])
}

struct CellData: Codable {
    let url: String
    let title: String?
    let color: [String]
    
    init(url: String, title: String?, color: [String]) {
        self.url = url
        self.title = title
        self.color = color
    }
    
    static let EMPTY = CellData(url: "", title: "", color: [])
}
