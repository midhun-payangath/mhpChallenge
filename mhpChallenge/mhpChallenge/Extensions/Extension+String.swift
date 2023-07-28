//
//  Extension+String.swift
//  mhpChallenge
//
//  Created by MacBook Pro on 28/07/23.
//

import Foundation

extension String {
    var isBlank: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
extension Optional where Wrapped == String {
    func getValue(optional: String = "-") -> String {
        if let unwrapped = self, !unwrapped.isBlank {
            return unwrapped
        }
        else {
            return optional
        }
    }
}
