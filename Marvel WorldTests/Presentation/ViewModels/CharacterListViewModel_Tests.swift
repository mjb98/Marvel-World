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
    
    override func setUp() {
        super.setUp()
        let storageController = MockFavouriteStorageController()
        let characterLoader = MockCharacterloader()
        MockCharacterloader.souldFail = false
        sut = .init(characterLoader: characterLoader, favouritesStorageController: storageController)
    }
    
    override  func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func test_fetchingCharacter_alwaysRequestSucess()  {
        let didReceiveResponse = expectation(description: #function)
        self.sut.fetchCharacters()
        self.sut.$characters.dropFirst().sink { _ in
            didReceiveResponse.fulfill()
        }.store(in: &sut.cancelables)
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_fetchingCharacter_alwaysRequestFails()  {
        MockCharacterloader.souldFail = true
        self.sut.fetchCharacters()
        let didReceiveResponse = expectation(description: #function)
        self.sut.$networkError.dropFirst().sink { error in
            if error != nil {
                didReceiveResponse.fulfill()
            }
            
        }.store(in: &sut.cancelables)
        waitForExpectations(timeout: 5, handler: nil)
        
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




