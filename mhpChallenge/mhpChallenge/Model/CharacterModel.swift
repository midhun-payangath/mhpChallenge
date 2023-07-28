//
//  CharacterModel.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let url: URL?
    let name: String?
    let gender: String?
    let culture: String?
    let born, died: String?
    let titles, aliases: [String]?
    let father, mother, spouse: String?
    let allegiances, books: [String]?
    let povBooks: [String]?
    let tvSeries: [String]?
    let playedBy: [String]?
}
