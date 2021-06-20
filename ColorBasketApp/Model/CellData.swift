//
//  CellData.swift
//  ColorBasketApp
//
//  Created by apple on 2021/06/10.
//

import UIKit


struct APIResponse: Codable {
    let data: [ServerData]
}

struct ServerData: Codable {
    let url: String
    let title: String?
//    let color: [String]
}

struct CellInfo {
    var image: UIImage
    var title: String
//    var color: [String]
}
