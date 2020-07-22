//
//  AppError.swift
//  Loblaw
//
//  Created by Chuks Udeogu on 2020-07-21.
//  Copyright © 2020 Puzzerax Inc. All rights reserved.
//

import Foundation

enum AppError: Error {
    case general
    case invalidURL
    case imageFetchFailed
    case invalidResponse
}

extension AppError {
    var userInfo: [String : Any] {
        switch self {
        case .general:
            return [NSLocalizedDescriptionKey: "Something went wrong"]
        case .invalidURL:
            return [NSLocalizedDescriptionKey: "Invalid URL"]
        case .imageFetchFailed:
            return [NSLocalizedDescriptionKey: "Couldn't fetch email"]
        case .invalidResponse:
            return [NSLocalizedDescriptionKey: "Invalid Response"]
        }
    }
}
