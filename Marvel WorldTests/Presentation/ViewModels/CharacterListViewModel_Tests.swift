//
//  CharacterListViewModel_Tests.swift
//  Marvel WorldTests
//
//  Created by Mohammad Javad Bashtani on 3/19/1400 AP.
//

import Combine
import XCTest
@testable import Marvel_World

class CharacterListViewModel_Tests: XCTestCase {
    var sut: CharacterListViewModel!

    override func setUpWithError() throws {
        let storageController = MockFavouriteStorageController()
        let characterLoader = MockCharacterloader()
        MockCharacterloader.souldFail = false
        sut = .init(characterLoader: characterLoader, favouritesStorageController: storageController)
    }

    func test_fetchingCharacter_alwaysRequestSucess()  {
       let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        sut?.fetchCharacters()
        dispatchGroup.leave()
      
        dispatchGroup.notify(queue: .main) {
            XCTAssert((self.sut.characters.count)  > 0)
        }

    }
    
    func test_fetchingCharacter_alwaysRequestFails()  {
        MockCharacterloader.souldFail = true
       let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        sut?.fetchCharacters()
        dispatchGroup.leave()
      
        dispatchGroup.notify(queue: .main) {
            XCTAssertFalse(self.sut.networkError != nil)
        }

    }
    
    func test_didSearch() {
        sut?.didSearch(query: "")
        XCTAssertTrue(sut.isMoreDataAvailable)
    }
    
    func test_didCanselSearch() {
        sut?.didCancelSearch()
        XCTAssertTrue(sut.isMoreDataAvailable)
    }
    
    func test_showFavouriteCharacters() {
        sut.showFavouriteCharacters()
        XCTAssert(sut.favouritesStorageController.fetchAll() == sut.characters)
    }
    
    func test_hideFavouriteCharacters() {
        sut.hideFavouriteCharacters()
        XCTAssert(sut.characters.isEmpty)
    }

}




