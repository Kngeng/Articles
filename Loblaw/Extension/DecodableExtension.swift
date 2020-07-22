//
//  DecodableExtension.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-21.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import Foundation

extension Decodable {
    private static func decode<T: Decodable>(json: [String: Any]) -> T? {
        guard let data = json.data else {
            return nil
        }
        
       return decode(data: data)
    }
    
    private static func decode<T: Decodable>(data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        guard let appData = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        
        return appData
    }
    
    init?(json: [String: Any])  {
        guard let data = json.data else {
            return nil
        }
        
        self.init(data: data)
    }
    
    init?(data: Data)  {
        let optionalDecodedObject: Self? = Self.decode(data: data)
        
        guard let decodedObject = optionalDecodedObject else {
            return nil
        }
        
        self = decodedObject
    }
}
