//
//  HousesListView.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import SwiftUI

struct HousesListView: View {
    
    @StateObject private var viewModel: HousesListViewModel
    
    init(service: IGOTService = GOTService()) {
        _viewModel = StateObject(wrappedValue: HousesListViewModel(service: service))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.state.houses, id: \.self) { movie in
                        HousesListItem(house: movie)
                }
                if viewModel.state.canLoadNextPage {
                    Button(action: {
                        viewModel.fetchNextPageIfPossible()
                    }) { Text(AppConstant.Txt.loadMore) }
                }
            }
            .navigationTitle(AppConstant.Txt.houses)
            .alert(isPresented: $viewModel.state.showAlert) {
                Alert(title: Text(viewModel.state.message), dismissButton: .cancel(Text(AppConstant.Txt.reTry), action: {
                    viewModel.refreshData()
                }))
            }
        }
    }
}

struct HousesListView_Previews: PreviewProvider {
    static var previews: some View {
        HousesListView()
    }
}
