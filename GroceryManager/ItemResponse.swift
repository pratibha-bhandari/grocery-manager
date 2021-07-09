//
//  ItemResponse.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 28/04/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation

struct ItemResponse: Codable {
    var data: [Item]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(Array.self, forKey: .data)
    }
}
