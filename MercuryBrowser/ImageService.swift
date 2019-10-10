//
//  ImageService.swift
//  MercuryBrowser
//
//  Created by Gabriela Garcia on 10/9/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//
import UIKit

struct ImageService{
    let imageCache = NSCache<NSString, UIImage>()
    func getImage(url: URL, completion: @escaping ((UIImage) -> Void)) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                  completion(cachedImage)
        }
        else{
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: url){
                (data, response, error) in
                if  let data = data {
                    let image = UIImage(data: data)
                    self.imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                    completion(image!)
                }
            }
            task.resume()
        }
    }
}
