//
//  HouseModel.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

// MARK: - HouseModel
struct HouseModel: Codable, Hashable {
    let url: URL?
    let name, region, coatOfArms, words: String?
    let titles, seats: [String]?
    let currentLord, heir, overlord: String?
    let founded: String?
    let founder: String?
    let diedOut: String?
    let ancestralWeapons: [String]?
    let cadetBranches, swornMembers: [URL]?
}

extension HouseModel {
    func getswornMembersIdList() -> [String] {
        return swornMembers?.compactMap{ $0.lastPathComponent} ?? []
    }
}
