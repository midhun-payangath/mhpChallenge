//
//  HouseDetailView.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import SwiftUI

struct HouseDetailView: View {
    
    @StateObject private var viewModel: HouseDetailViewModel
    
    init(service: IGOTService = GOTService(), id: String) {
        _viewModel = StateObject(wrappedValue: HouseDetailViewModel(service: service, id: id))
    }
    
    var body: some View {
        GeometryReader { geometry in
            List {
                if viewModel.state.houseDetail != nil {
                    factsView
                    titlesView
                    seatsView
                    ancestralWeaponsView
                    swornMembersView
                }
            }
            .listStyle(.sidebar)
            .navigationBarTitle(AppConstant.Txt.details, displayMode: .inline)
            .alert(isPresented: $viewModel.state.showAlert) {
                Alert(title: Text(viewModel.state.message), dismissButton: .cancel(Text(AppConstant.Txt.reTry), action: {}))
            }
        }
    }
}

struct HouseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HouseDetailView(id: "")
    }
}


extension HouseDetailView {
    
    private var house: HouseModel? {
        viewModel.state.houseDetail
    }
    
    @ViewBuilder
    private var factsView: some View {
        Section(header: Text(AppConstant.Txt.facts)) {
            propertyView(type: .name, value: house?.name)
            propertyView(type: .region, value: house?.region)
            propertyView(type: .founded, value: house?.founded)
            propertyView(type: .diedOut, value: house?.diedOut)
            propertyView(type: .words, value: house?.words)
            propertyView(type: .coatOfArms, value: house?.coatOfArms)
        }
    }
    
    @ViewBuilder
    private var titlesView: some View {
        Section(header: Text(AppConstant.Txt.titles + " (\(house?.titles?.count ?? 0))")) {
            if let titles = house?.titles {
                showTitles(titles: titles)
            }
        }
    }
    
    @ViewBuilder
    private var seatsView: some View {
        Section(header: Text(AppConstant.Txt.seats + " (\(house?.seats?.count ?? 0))")) {
            if let seats = house?.seats {
                showTitles(titles: seats)
            }
        }
    }
    
    @ViewBuilder
    private var ancestralWeaponsView: some View {
        Section(header: Text(AppConstant.Txt.ancestralWeapons + " (\(house?.ancestralWeapons?.count ?? 0))")) {
            if let ancestralWeapons = house?.ancestralWeapons {
                showTitles(titles: ancestralWeapons)
            }
        }
    }
    
    @ViewBuilder
    private var swornMembersView: some View {
        Section(header: Text(AppConstant.Txt.swornMembers + " (\(viewModel.state.swornMembers.count))")) {
            showTitles(titles: viewModel.state.swornMembers)
        }
    }
    
    private func propertyView(type: PropertyView, value: String?) -> some View {
        var title = ""
        switch type {
        case .name:
            title = AppConstant.Txt.name
        case .region:
            title = AppConstant.Txt.region
        case .founded:
            title = AppConstant.Txt.founded
        case .diedOut:
            title = AppConstant.Txt.diedOut
        case .words:
            title = AppConstant.Txt.words
        case .coatOfArms:
            title = AppConstant.Txt.coatOfArms
        }
        
        return HStack(alignment: .top) {
            Text(title)
                .fontWeight(.semibold)
            Text(value.getValue())
        }
        .font(.subheadline)
    }
    
    private func showTitles(titles: [String?]) -> some View {
        ForEach(titles, id: \.self) { titl in
            Text(titl.getValue())
                .font(.subheadline)
        }
    }
}
