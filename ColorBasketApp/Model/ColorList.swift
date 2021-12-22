//
//  ColorList.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/11.
//

import Foundation

class ColorList {
    var colorList: [TouchColorView]
    
    init(colorList: [TouchColorView]) {
        self.colorList = colorList
    }
    
    static let EMPTY = ColorList.init(colorList: [])
}
