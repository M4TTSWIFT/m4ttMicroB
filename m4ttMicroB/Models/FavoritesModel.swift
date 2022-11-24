//
//  FavoriteModel.swift
//  m4ttMicroB
//
//  Created by Mac on 24.11.2022.
//

import Foundation
import RealmSwift

class FavoritesModel: Object {
    @objc dynamic var nameLabel: String = ""
    @objc dynamic var genresLabel: String = ""
    @objc dynamic var ratingLabel: String = ""
    @objc dynamic var id: Int = 0
}
