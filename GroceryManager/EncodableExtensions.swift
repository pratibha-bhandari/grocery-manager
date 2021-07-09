//
//  EncodableExtensions.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 12/06/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation

enum GMError: Error {
    case encodingError
}

extension Encodable {
    func toJson(excluding keys:[String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any] else {throw GMError.encodingError}
        
        for key in keys {
            json[key] = nil
        }
        return json
    }
}
