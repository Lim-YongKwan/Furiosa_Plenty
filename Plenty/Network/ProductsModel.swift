//
//  ProductsModel.swift
//  Plenty
//
//  Created by 임 용관 on 11/25/23.
//

import Foundation

struct ProductsModel: Codable {
    var Foods: [String]?
    var Energy: Float?
    var Carbohydrate: Float?
    var Protein: Float?
    var Province: Float?
    var Cholesterol: Float?
    var DietaryFiber: Float?
    var Sodium: Float?
    var Potassium: Float?
}

struct dailyModel: Codable {
    var Foods: [String]?
    var Energy: Float?
    var Carbohydrate: Float?
    var Protein: Float?
    var Province: Float?
    var Cholesterol: Float?
    var DietaryFiber: Float?
    var Sodium: Float?
    var Potassium: Float?
}
