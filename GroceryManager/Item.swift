//
//  Item.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 28/04/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation

/*struct Item: Identifiable, Codable {
     
}*/




protocol Identifiable {
    var id: String? {get set}
}
struct Item: Codable, Identifiable {
    var id: String? = nil
    var title: String
    var quantity: String
    var unit: String
    init(title: String, quantity: String, unit: String){
        self.title = title
        self.quantity = quantity
        self.unit = unit
    }
}


/*struct Item: Codable {
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }
}*/
