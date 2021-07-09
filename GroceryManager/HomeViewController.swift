//
//  HomeViewController.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 28/04/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: HomeViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel = HomeViewModel(reloadTableViewCallback:reloadTableViewData)
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.retrieveData()
    }
    
    func setUpTableView() {
        tableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    func reloadTableViewData() {
        tableView.reloadData()
    }
    //MARK: Actions
    
    @IBAction func addButtonClicked(_ sender: Any) {
        
       performSegue(withIdentifier: "addItem", sender: nil)
        
        /*let item = Item(title: "Fox Nut")
        FIRFirestoreService.shared.add(for: item)
        let alert = UIAlertController(title: "Alert", message: "Item Added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { (action:UIAlertAction!) in
            print("Cancel")
        })
        self.present(alert, animated: true) {
            print("presented")
        }
        self.viewModel.retrieveData()*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let updateItemViewController = segue.destination as? UpdateItemViewController, let item = sender as? Item {
            updateItemViewController.item = item
        }
    }
    
    func updateItem(updatedQuanity: String, selectedItem: inout Item) {
        selectedItem.quantity = updatedQuanity
        viewModel.updateData(item: selectedItem)
    }
}

extension HomeViewController  {
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.setUpTableViewCell(indexPath: indexPath, tableView: tableView)
    }
}
extension HomeViewController  {
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("didSelectRowAt")
        var selectedItem = self.viewModel.didSelectRowAt(indexPath: indexPath)
        //performSegue(withIdentifier: "updateItem", sender: selectedItem)
        
        //Update popup
        /*let alert = UIAlertController(title: "Alert", message: "Item Added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
        
        let alertController = UIAlertController(title: selectedItem.title, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = selectedItem.quantity
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))

        let submitAction = UIAlertAction(title: "Update", style: .default) { [unowned alertController] _ in
            let updatedValue = alertController.textFields![0].text
            self.updateItem(updatedQuanity: updatedValue!, selectedItem: &selectedItem)
        }

        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        print("delete")
        let selectedItem = self.viewModel.didSelectRowAt(indexPath: indexPath)
        viewModel.deleteData(item: selectedItem)
    }

}


