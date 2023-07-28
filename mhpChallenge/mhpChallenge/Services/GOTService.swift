//
//  GOTService.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

protocol IGOTService {
    func getHousesList(page: Int, size: Int) async throws -> [HouseModel]
    func getHouseDetail(id: String) async throws -> HouseModel
    func getCharacterDetail(id: String) async throws -> CharacterModel
}

struct GOTService: IGOTService, ApiRepository {
    func getHousesList(page: Int, size: Int) async throws -> [HouseModel] {
        return try await sendRequest(endpoint: ApiEndpoints.housesList(page: page, size: size), responseModel: [HouseModel].self)
    }
    
    func getHouseDetail(id: String) async throws -> HouseModel {
        return try await sendRequest(endpoint: ApiEndpoints.houseDetail(id: id), responseModel: HouseModel.self)
    }
    
    func getCharacterDetail(id: String) async throws -> CharacterModel {
        return try await sendRequest(endpoint: ApiEndpoints.characterDetail(id: id), responseModel: CharacterModel.self)
    }
}
