//
//  Service.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-21.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import Foundation
import UIKit

class Service {
    class func getImage(for urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void ) {
        guard let imageUrl = URL(string : urlString) else {
            completion(.failure(AppError.invalidURL))
            return
        }
        
        makeURLSessionDownloadConnection(with: imageUrl, completionHandler: { (url, response, error) in
            if let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(AppError.imageFetchFailed))
            }
        })
    }
    
    private class func makeCall<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> (Void)) {
        guard let url = URL(string: urlString) else {
            completion(.failure(AppError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        print("Service Request ---> URL ---> " + urlString)
        makeURLSessionDataConnection(with: request) { (data, response, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                print("Service Response ---> URL ---> " + urlString)
                completion(.failure(AppError.invalidResponse))
                return
            }
            
            print("Service Response ---> URL ---> " + urlString + " json ---> \(json)")
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(AppError.general))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(AppError.general))
                return
            }
            
            if let value = T(json: json) {
                completion(.success(value))
            } else {
                completion(.failure(AppError.general))
            }
        }
    }

    private class func makeURLSessionDataConnection(with request: URLRequest, completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = urlSession.dataTask(with: request, completionHandler: completionHandler)
        dataTask.resume()
    }
    
    private class func makeURLSessionDownloadConnection(with url: URL, completionHandler: @escaping (_ url : URL?, _ response : URLResponse?, _ error :Error?) -> Void) {
            
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let downloadTask = urlSession.downloadTask(with: url, completionHandler: completionHandler)
        downloadTask.resume()
    }
}

extension Service {
    class func getArticles(completion: @escaping (Result<Listing, Error>) -> (Void)) {
        Service.makeCall(urlString: "https://www.reddit.com/r/swift/.json", completion: completion)
    }
}
