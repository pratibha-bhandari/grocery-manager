//
//  FIRFirestoreService.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 12/06/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FIRFirestoreService {
    private init() {}
    static let shared = FIRFirestoreService()
    
    func configure() {
        FirebaseApp.configure()
    }
    func read<T: Decodable>(returning objectType: T.Type, completion: @escaping([T]) -> Void) {
        let db = Firestore.firestore()
        db.collection("items").getDocuments { (querySnapshot, error) in
            
            guard let snapshot = querySnapshot else {return}
            do {
                var objects = [T]()
                for document in snapshot.documents {
                    print("\(document.documentID) => \(document.data())")
                    let object  = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                //self.reloadTableViewCallback()
                completion(objects)
            }catch {
                print(error)
            }
            
        }
    }
    func add<T: Codable>(for encodableObject: T, completion: @escaping() -> Void) {
        
        do {
            let json = try encodableObject.toJson()
            
            let db = Firestore.firestore()
            //let params: [String: Any] = ["title": "Sugar"]
            
            db.collection("items").addDocument(data: json) { (error) in
                
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    print("Data added")
                    completion()
                }
            }
        }catch {
            print(error)
        }
        
    }
    func delete<T: Identifiable>(_ identifiableObject: T, completion: @escaping()-> Void) {
        do {
            guard let id = identifiableObject.id else {
                throw GMError.encodingError
            }
            let db = Firestore.firestore()
            db.collection("items").document(id).delete { (error) in
                if let err = error {
                    print("Error deleting document: \(err)")
                } else {
                    print("Document deleted")
                    completion()
                }
            }
        } catch {
            print(error)
        }
        
    }
    func update<T: Codable & Identifiable>(for encodableObject: T, completion: @escaping() -> Void) {
        //setData(["title":"Rice"])
        do {
            let json = try encodableObject.toJson(excluding: ["id"])
            guard let id = encodableObject.id else {
                throw GMError.encodingError
            }
            
            let db = Firestore.firestore()
            //let params: [String: Any] = ["title": "Sugar"]
            
            db.collection("items").document(id).setData(json) { (error) in
                if let err = error {
                    print("Error getting documents: \(err)")
                } else {
                    print("Data updated")
                    completion()
                }
            }
        }catch {
            print(error)
        }
        
    }
}
