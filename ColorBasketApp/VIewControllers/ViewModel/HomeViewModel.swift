//
//  HomeViewModel.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/28.
//

import Foundation

class HomeViewModel: NSObject {
    var repository: Repository = Repository()
    private var homeImage: ServerData = ServerData.EMPTY
    var imageCollection: () -> Void = {}
    var cardCollection: () -> Void = {}
    var startLoading: () -> Void = {}
    var stopLoading: () -> Void = {}
    
    func list() {
        repository.ImageList { cellDataList in
            self.homeImage.data = cellDataList
            self.imageCollection()
        }
    }
    
    func more() {
        startLoading()
        repository.ImageList { cellDataList in
            cellDataList.map{ self.homeImage.data.append($0) }
            self.cardCollection()
            self.stopLoading()
        }
    }
    
    func getCount() -> Int {
        return homeImage.data.count
    }
    
    func cellDatas() -> [JsonData] {
        return homeImage.data
    }
    
    func getData(index: Int) -> JsonData {
        return homeImage.data[index]
    }
    
    func refresh() {
        homeImage = .EMPTY
        list()
    }
}
