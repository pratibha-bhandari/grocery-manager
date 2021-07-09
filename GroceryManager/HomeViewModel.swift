//
//  HomeViewModel.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 28/04/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import UIKit
import FirebaseFirestore

class HomeViewModel: NSObject {
    var reloadTableViewCallback: (()->())!
    var itemsArray = [Item]()
    init(reloadTableViewCallback:@escaping (()->())) {
        super.init()
        self.reloadTableViewCallback = reloadTableViewCallback
    }
    func retrieveData() {
        
        FIRFirestoreService.shared.read(returning: Item.self) { (items) in
            print(items)
            self.itemsArray = items
            self.reloadTableViewCallback()
        }
        /*let db = Firestore.firestore()
        db.collection("items").getDocuments { (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
                //self.reloadTableViewCallback()
            }
        }*/
        /*NetworkManager.sharedManager.getItems { (response) in
            print("Received items")
            let data = response.data!
            let decoder = JSONDecoder()
            let itemsResponse = try! decoder.decode(ItemResponse.self, from: data)
            print(itemsResponse)
            self.itemsArray = itemsResponse.data ?? []
            self.reloadTableViewCallback()
        }*/
    }
    func updateData(item: Item) {
        FIRFirestoreService.shared.update(for: item,  completion: {
            print("Updated")
            self.retrieveData()
        })
    }
    func deleteData(item: Item) {
        FIRFirestoreService.shared.delete(item) {
            print("Deleted")
            self.retrieveData()
        }
    }
    //MARK: To Setup TableView Data
    func numberOfRowsInSection() -> Int{
        return itemsArray.count
    }
    func setUpTableViewCell(indexPath: IndexPath, tableView: UITableView)-> UITableViewCell {
        let item = itemsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemTableViewCell
        cell.titleLabel.text = item.title
        cell.quantityLabel.text = item.quantity
        cell.unitLabel.text = item.unit
        return cell
    }
    func didSelectRowAt(indexPath: IndexPath)-> Item {
        let item = itemsArray[indexPath.row]
        return item
    }
}


