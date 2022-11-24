//
//  Storage.swift
//  m4ttMicroB
//
//  Created by Mac on 24.11.2022.
//

import Foundation
import RealmSwift

class Storage {
    
    static let shared = Storage()
    
    private let realm = try! Realm()
    let results = try! Realm().objects(FavoritesModel.self)
    
    func save(_ savedItem: FavoritesModel) {
        let items = savedItem
        
        try! realm.write {
            realm.add([items])
        }
    }
    
    
    func remove(_ indexPath: Int) {
        try! realm.write {
            realm.delete(results[indexPath])
        }
    }
    
}
