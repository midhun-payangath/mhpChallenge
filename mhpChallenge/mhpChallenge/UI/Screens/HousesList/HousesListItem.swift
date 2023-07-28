//
//  HousesListItem.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import SwiftUI

struct HousesListItem: View {
    var house: HouseModel
    
    var body: some View {
        HStack {
            IconView
            VStack(alignment: .leading) {
                homeNameView
                regionNameView
            }
        }
        .padding(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
    }
}


extension HousesListItem {
    
    @ViewBuilder
    private var IconView: some View {
        Image(AppConstant.Image.house)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25, alignment: .center)
    }
    
    @ViewBuilder
    private var homeNameView: some View {
        if let name  = house.name {
            Text(name)
                .font(.subheadline)
        }
    }
    
    @ViewBuilder
    private var regionNameView: some View {
        if let region  = house.region {
            Text(region)
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
}
