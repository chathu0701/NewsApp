//
//  EnhancedUIImageView.swift
//  NewsApp
//
//  Created by Chathurika Bandara on 4/26/22.
//

import UIKit

/*
 ADDED FEATURES
    Download image from URL with caching
*/

fileprivate let imageCache = NSCache<NSString,UIImage>()

class EnhancedUIImageView: UIImageView {

    private var dataTask: URLSessionDataTask? = nil

    final fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        self.dataTask = URLSession.shared.dataTask(with: url, completionHandler: completion)
        self.dataTask!.resume()
    }

    //Download image with provided url
    final func downloadImage(from url: String?, defaultImage: UIImage?, onComplete: ((Bool) -> ())?) {
        //cancel any pending requests, important when using inside UITableViewsCells
        self.dataTask?.cancel()
        self.image = nil
        guard let url = URL(string: url ?? "") else {
            onComplete?(false)
            self.image = defaultImage
            return
        }
        //Look for cached images
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            onComplete?(true)
            self.image = cachedImage
        } else {
            //if image is not available in cache, download
            getData(from: url) { data, response, error in
                DispatchQueue.main.async() {
                    guard let data = data else {
                        onComplete?(false)
                        if let error = error  {
                            if (error as NSError).code == NSURLErrorCancelled {
                                return
                            }
                        }
                        self.image = defaultImage
                        return
                    }

                    guard let image = UIImage(data: data) else {
                        onComplete?(false)
                        self.image = defaultImage
                        return
                    }
                    onComplete?(true)
                    self.image = image
                    // add downloaded image to cache.
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                }
            }
        }
    }
}
