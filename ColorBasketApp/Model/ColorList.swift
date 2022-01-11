//
//  ColorList.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/11.
//

import Foundation
import UIKit

class ColorList {
    var colorViewList: [TouchColorView]
    var colorList: [UIColor]
    
    init(colorViewList: [TouchColorView], colorList: [UIColor]) {
        self.colorViewList = colorViewList
        self.colorList = colorList
    }
    
    static let EMPTY = ColorList.init(colorViewList: [], colorList: [])
}
