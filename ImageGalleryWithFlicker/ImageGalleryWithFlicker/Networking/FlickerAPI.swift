//
//  FlickerAPI.swift
//  ImageGalleryWithFlicker
//
//  Created by hiroshi on 2019/06/29.
//  Copyright © 2019 hiroshi. All rights reserved.
//

import Foundation

class FlickerAPI {
    
    private let baseURL = "https://www.flickr.com/services/feeds/photos_public.gne/"
    
    private let commonQuery = ["format": "json", "nojsoncallback": "1"]
    
    var url: URL?
    
    init(query: [String:String]?) {
        url = setURL(query: query)
    }
    
    /// set url with query parameters
    private func setURL(query: [String:String]?) -> URL {
        var components = URLComponents(string: baseURL)!
        var queryItems = [URLQueryItem]()
        
        // set common query parameters
        for (key,value) in commonQuery {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        // set current query parameters
        if let additionalQueryItems = query {
            for (key, value) in additionalQueryItems {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    /// request 
    func requestPhotoData(completion: @escaping ([Photo]) -> Void) {
        guard let url = self.url else {
            print("URL is nil!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check error
            if let e = error {
                print(e.localizedDescription)
                return
            }
            // check response
            if let r = response as? HTTPURLResponse,
                r.statusCode == 200,
                let d = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let photos = try decoder.decode(FlickerResponse.self, from: d)
                    completion(photos.items)
                } catch {
                    print("error: ", error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
