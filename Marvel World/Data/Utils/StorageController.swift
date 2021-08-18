//
//  StorageController.swift
//  Marvel World
//
//  Created by Mohammad Javad Bashtani on 3/17/1400 AP.
//

import Foundation

protocol FavouriteStorageController: class {
    func save(_ : [Character])
    func fetchAll() -> [Character]
    func removeAll()
    func add(_ : Character)
    func remove(_ : Character)
    func contains(_ : Character) -> Bool
}

class FavouritesFileStroageController: FavouriteStorageController {
    
    private let documentsDirectoryURL = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first!
    
    private var favouritesFileUrl: URL {
        return documentsDirectoryURL
            .appendingPathComponent("fav")
            .appendingPathExtension("json")
        
    }
    
    func save(_ characters: [Character]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(characters) else { return }
        try? data.write(to: favouritesFileUrl)
        
    }
    
    func fetchAll() -> [Character] {
        guard let data = try? Data(contentsOf: favouritesFileUrl) else { return [] }
        let decoder = JSONDecoder()
        let venues = try? decoder.decode([Character].self, from: data)
        return venues ?? []
    }
    
    func removeAll() {
        try? FileManager.default.removeItem(at: favouritesFileUrl)
    }
    
    func add(_ character: Character) {
        var characters = fetchAll()
        characters.append(character)
        save(characters.uniqued())
    }
    
    func remove(_ character : Character) {
        var characters = fetchAll()
        characters.removeAll {
            $0 == character
        }
        save(characters)
    }

    func contains(_ character: Character) -> Bool {
        fetchAll().contains(character)
    }
    
    
    
}
