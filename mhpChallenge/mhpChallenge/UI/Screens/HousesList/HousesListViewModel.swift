//
//  HousesListViewModel.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation
import Combine

@MainActor
class HousesListViewModel: ObservableObject {

    @Published var state = State()
    private var service: IGOTService
    
    struct State {
        var houses: [HouseModel] = []
        var page: Int = 1
        var canLoadNextPage: Bool = true
        var message: String = ""
        var showAlert: Bool = false
    }
    
    
    init(service: IGOTService) {
        self.service = service
        self.fetchNextPageIfPossible()
    }
    
    func refreshData() {
        self.state = State()
        fetchNextPageIfPossible()
    }
    
    func fetchNextPageIfPossible() {
        guard state.canLoadNextPage else { return }
        Task {
            do {
                let result = try await service.getHousesList(page: state.page, size: AppConstant.Pagination.houseList)
                self.state.houses += result
                self.state.page += 1
                if result.count < AppConstant.Pagination.houseList {
                    self.state.canLoadNextPage = false
                }
                else {
                    self.state.canLoadNextPage = true
                }
            }
            catch(let error as RequestError) {
                self.state.canLoadNextPage = false
                self.state.message = error.customMessage
                self.state.showAlert = true
            }
        }
    }
}
