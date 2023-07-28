//
//  MockGOTService.swift
//  mhpChallengeTests
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation
@testable import mhpChallenge

struct MockGOTService: IGOTService {
            
    func getHousesList(page: Int, size: Int) async throws -> [HouseModel] {
        
        if let path = Bundle.main.path(forResource: AppConstant.Json.houses, ofType: "json"), let data = FileManager.default.contents(atPath: path) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            guard let decodedResponse = try? decoder.decode([HouseModel].self, from: data) else {
                throw RequestError.decode
            }
            return decodedResponse
        }
        else {
            throw RequestError.noResponse
        }
    }
    
    
    func getHouseDetail(id: String) async throws -> HouseModel {
        throw RequestError.invalidURL
    }
    
    
    func getCharacterDetail(id: String) async throws -> CharacterModel {
        if let path = Bundle.main.path(forResource: AppConstant.Json.character, ofType: "json"), let data = FileManager.default.contents(atPath: path) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            guard let decodedResponse = try? decoder.decode(CharacterModel.self, from: data) else {
                throw RequestError.decode
            }
            return decodedResponse
        }
        else {
            throw RequestError.noResponse
        }
    }
}

