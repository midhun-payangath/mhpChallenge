//
//  HouseDetailViewModel.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation
import Combine

@MainActor
class HouseDetailViewModel: ObservableObject {
    
    @Published var state: State = State()
    private var service: IGOTService
    private var houseId: String
    
    struct State {
        var houseDetail: HouseModel? = nil
        var swornMembers: [String] = []
        var message: String = ""
        var showAlert: Bool = false
    }
    
    init(service: IGOTService, id: String) {
        self.service = service
        self.houseId = id
        self.fetchhouseDetail()
    }
    
    func fetchhouseDetail() {
        Task {
            do {
                let result = try await service.getHouseDetail(id: self.houseId)
                self.state.houseDetail = result
                await fetchSwornMembers(ids: result.getswornMembersIdList())
            }
            catch(let error as RequestError) {
                self.state.message = error.customMessage
                self.state.showAlert = true
            }
        }
    }
        
    func fetchSwornMembers(ids: [String]) async {
        do {
            try await withThrowingTaskGroup(of: CharacterModel.self) { group in
                for id in ids {
                    group.addTask{
                        let character = try await self.service.getCharacterDetail(id: id)
                        return character
                    }
                }
                for try await character in group {
                    self.state.swornMembers.append(character.name.getValue())
                }
            }
        }
        catch {}
    }
}
