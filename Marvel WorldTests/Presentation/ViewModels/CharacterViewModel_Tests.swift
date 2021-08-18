//
//  CharacterViewModel_Tests.swift
//  Marvel WorldTests
//
//  Created by Mohammad Javad Bashtani on 3/20/1400 AP.
//

import XCTest
@testable import Marvel_World

class CharacterViewModel_Tests: XCTestCase {
    var sut: CharacterViewModel!
    override func setUpWithError() throws {
        sut = .init(character: StubCharacter.getCharacter(), favouriteStroageController: MockFavouriteStorageController())
    }
    
    func test_modifyFavouriteState() {
        let isFavouried = sut.isFavourited
        sut.modifyFavouriteState()
        XCTAssert(isFavouried != sut.isFavourited)
    }
    

}
