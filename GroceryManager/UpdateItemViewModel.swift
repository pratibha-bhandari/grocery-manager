//
//  UpdateItemViewModel.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 14/06/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation

class UpdateItemViewModel: NSObject {
    var reloadDataCallback: (()->())!
    init(reloadDataCallback:@escaping (()->())) {
        super.init()
        self.reloadDataCallback = reloadDataCallback
    }
    func updateData(item: Item) {
        FIRFirestoreService.shared.update(for: item,  completion: {
            print("Updated")
            self.reloadDataCallback()
        })
    }
}

