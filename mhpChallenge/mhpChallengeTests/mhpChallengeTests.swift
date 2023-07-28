//
//  mhpChallengeTests.swift
//  mhpChallengeTests
//
//  Created by MacBook Pro on 28/07/23.
//

import XCTest
@testable import mhpChallenge

final class mhpChallengeTests: XCTestCase {

    func testHousesListSuccess() async throws {
        do {
            let gotService = MockGOTService()
            let result = try await gotService.getHousesList(page: 1, size: 5)
            XCTAssertEqual(result.count, 5)
            XCTAssertEqual(result.first?.name, "House Algood")
            XCTAssertEqual(result.last?.seats?.count, 1)
        }
        catch(_) {
        }
    }
    
    func testHouseDetailFailure() async throws {
        do {
            let gotService = MockGOTService()
            let result = try await gotService.getHouseDetail(id: "13")
        }
        catch(let error as RequestError) {
            XCTAssertEqual(error.customMessage, RequestError.invalidURL.customMessage)
        }
    }
    
    func testCharacterSuccess() async throws {
        do {
            let gotService = MockGOTService()
            let result = try await gotService.getCharacterDetail(id: "1301")
            XCTAssertEqual(result.name, "Daemon Sand")
            XCTAssertEqual(result.aliases?.count, 1)            
        }
        catch(_) {
        }
    }

}
