//
//  ApiRepository.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum RequestError: LocalizedError {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case other(String)
    
    var customMessage: String {
        switch self {
        case .invalidURL:
            return AppConstant.Txt.invalidURL
        case .decode:
            return AppConstant.Txt.decode
        case .unauthorized:
            return AppConstant.Txt.unauthorized
        case .other(let errorMsg):
            return errorMsg
        default:
            return AppConstant.Txt.other
        }
    }
}

protocol ApiRepository {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

extension ApiRepository {
    func sendRequest<T: Decodable>( endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? decoder.decode(responseModel, from: data) else {
                    throw RequestError.decode
                }
                return decodedResponse
            case 401:
                throw RequestError.unauthorized
            default:
                throw RequestError.unexpectedStatusCode
            }
        }
        catch(let error) {
            if error is RequestError {
                throw error
            }
            else {
                throw RequestError.other(error.localizedDescription)
            }
        }
    }
}
