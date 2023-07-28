//
//  ApiEndpoints.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

enum ApiEndpoints {
    case housesList(page: Int, size: Int)
    case houseDetail(id: String)
    case characterDetail(id: String)
}

extension ApiEndpoints: Endpoint {
    var path: String {
        switch self {
        case .housesList(let page, let size):
            return "/api/houses?page=\(page)&pageSize=\(size)"
        case .houseDetail(let id):
            return "/api/houses/\(id)"
        case .characterDetail(let id):
                return "/api/characters/\(id)"
        }
    }

    var method: RequestMethod {
        switch self {
        case .housesList, .houseDetail, .characterDetail:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .housesList, .houseDetail, .characterDetail:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .housesList, .houseDetail, .characterDetail:
            return nil
        }
    }
}
