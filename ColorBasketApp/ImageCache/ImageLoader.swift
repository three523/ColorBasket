//
//  ImageLoader.swift
//  ColorBasketApp
//
//  Created by apple on 2021/09/28.
//

import Foundation
import UIKit

class ImageLoader {
    private var imageCache = NSCache<NSString, UIImage>()
    var fileManager = FileManager()
    
    func loadImage(url: String, completed: @escaping(UIImage?) -> Void) {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
        let filePath = URL(fileURLWithPath: path)
        
        if let image = imageCache.object(forKey: url as NSString) {
            DispatchQueue.main.async {
                completed(image)
            }
        } else {
            addImage(url: url, filePath: filePath, completed: { image in
                completed(image)
            })
        }
    }
    
    private func addImage(url: String, filePath: URL, completed: @escaping (UIImage?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: URL(string: url)!) {
                let image = UIImage(data: data)!
                self.imageCache.setObject(image, forKey: url as NSString)
                self.fileManager.createFile(atPath: filePath.path, contents: image.jpegData(compressionQuality: 0.4), attributes: nil)
                DispatchQueue.main.async {
                    completed(image)
                }
            } else {
                DispatchQueue.main.async {
                    completed(nil)
                }
            }
        }
    }
}
