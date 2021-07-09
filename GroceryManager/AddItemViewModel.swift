//
//  AddItemViewModel.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 14/06/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation

class AddItemViewModel: NSObject {
    var reloadDataCallback: (()->())!
    init(reloadDataCallback:@escaping (()->())) {
        super.init()
        self.reloadDataCallback = reloadDataCallback
    }
    func addData(item: Item) {
        FIRFirestoreService.shared.add(for: item, completion: {
            print("Added")
            self.reloadDataCallback()
        })
    }
}

