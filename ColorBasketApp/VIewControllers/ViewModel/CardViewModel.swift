//
//  cardViewModel.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/11.
//

import Foundation
import UIKit

class CardViewModel: NSObject {
    var colorList: ColorList = ColorList.EMPTY
    static var maxCount = 3
    static var cardCollection: () -> Void = { }
    
    func getColorList() -> [UIColor] {
        if getCount() != 0 {
            var uiColorList: [UIColor] = []
            colorList.colorList.forEach { view in
                uiColorList.append(view.backgroundColor ?? UIColor(hexFromString: "121212")!)
            }
            if uiColorList.count < CardViewModel.maxCount {
                for _ in 0..<(CardViewModel.maxCount - uiColorList.count) {
                    uiColorList.append(UIColor(hexFromString: "121212")!)
                }
            }
            return uiColorList
        } else {
            return Array(repeating: UIColor(hexFromString: "121212")!, count: 6)
        }
    }
    
    func listAppend(view: TouchColorView) {
        if getCount() < CardViewModel.maxCount {
            colorList.colorList.append(view)
            CardViewModel.cardCollection()
        } else {
            let removeView = colorList.colorList.removeFirst()
            removeView.isSelected = !removeView.isSelected
            colorList.colorList.append(view)
            CardViewModel.cardCollection()
        }
    }
    
    func listRemove(view: TouchColorView) {
        colorList.colorList.removeAll{ $0 == view }
    }
    
    func getCount() -> Int {
        return colorList.colorList.count
    }
    
    func setMaxCount(maxCount: Int) {
        CardViewModel.maxCount = maxCount
    }
}
