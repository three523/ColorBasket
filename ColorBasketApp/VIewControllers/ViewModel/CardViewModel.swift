//
//  cardViewModel.swift
//  ColorBasketApp
//
//  Created by apple on 2021/12/11.
//

import Foundation
import UIKit

class CardViewModel: NSObject {
    var colorList: [ColorList] = Array(repeating: ColorList.EMPTY, count: 6)
    static var maxCount: [Int] = Array(repeating: 0, count: 6)
    static var cardCollection: () -> Void = { }
    
    func getColorList(maxCount: Int, index: Int) -> [UIColor] {
        CardViewModel.maxCount[index] = maxCount
        if getCount(index: index) != 0 {
            var uiColorList: [UIColor] = []
            colorList[index].colorList.forEach { color in
                uiColorList.append(color)
            }
            if uiColorList.count < CardViewModel.maxCount[index] {
                for _ in 0..<(CardViewModel.maxCount[index] - uiColorList.count) {
                    uiColorList.append(UIColor(hexFromString: "121212")!)
                }
            }
            return uiColorList
        } else {
            return Array(repeating: UIColor(hexFromString: "121212")!, count: maxCount)
        }
    }
    
    func listAppend(view: TouchColorView, index: Int) {
        if getCount(index: index) < CardViewModel.maxCount[index] {
            colorList[index].colorViewList.append(view)
            colorList[index].colorList.append(view.backgroundColor ?? UIColor.black)
        } else {
            colorList[index].colorList.removeFirst()
            let removeView = colorList[index].colorViewList.removeFirst()
            removeView.isSelected = !removeView.isSelected
            colorList[index].colorViewList.append(view)
            colorList[index].colorList.append(view.backgroundColor ?? UIColor.black)
            CardViewModel.cardCollection()
        }
    }
    
    func listRemove(view: TouchColorView, index: Int) {
        colorList[index].colorList.removeAll{ $0 == view.backgroundColor }
        colorList[index].colorViewList.removeAll{ $0 == view }
        CardViewModel.cardCollection()
    }
    
    func getCount(index: Int) -> Int {
        return colorList[index].colorViewList.count
    }
    
    func changeColorListView(index: Int) {
        
        print("aaaaa",colorList[0].colorList,"bbbb",colorList[1].colorList)
        let detailColorListView = colorList[index].colorViewList
        let detailColorList = colorList[index].colorList
        for index in 0..<detailColorList.count {
            detailColorListView[index].backgroundColor = detailColorList[index]
            detailColorListView[index].isSelected = true
        }
        CardViewModel.cardCollection()
    }
}
