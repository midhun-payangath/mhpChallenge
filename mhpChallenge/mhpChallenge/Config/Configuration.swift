//
//  Configuration.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

enum EnvConfig: String {
    case HOST
    
    static func value(_ key: EnvConfig) -> String {
        Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String ?? ""
    }
}
