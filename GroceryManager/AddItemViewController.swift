//
//  AddItemViewController.swift
//  GroceryManager
//
//  Created by Pratibha Bhandari on 13/06/21.
//  Copyright © 2021 Pratibha. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var titleTxtFld: UITextField!
    @IBOutlet weak var quantityTxtFld: UITextField!
    @IBOutlet weak var unitTxtFld: UITextField!
    
    let units = ["Kg", "Litre", "Pkt"]
    var viewModel: AddItemViewModel!
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.unitTxtFld.inputView = pickerView
        self.unitTxtFld.textAlignment = .center
        
        //Setup Toolbar with done button
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()

        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ViewController.cancelClick))
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        self.unitTxtFld.inputAccessoryView = toolBar
        
        viewModel = AddItemViewModel(reloadDataCallback:reloadData)
    }
    @IBAction func addButtonClicked(_ sender: Any) {
        
        if let title = self.titleTxtFld.text, let quantity = quantityTxtFld.text, let unit = unitTxtFld.text  {
            let item = Item(title: title, quantity: quantity, unit: unit)
            viewModel.addData(item: item)
        }
        
    }
    func reloadData() {
        
        titleTxtFld.text = ""
        quantityTxtFld.text = ""
        unitTxtFld.text = ""
        
        let alert = UIAlertController(title: "Alert", message: "Item Added", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func doneButtonClicked() {
        self.unitTxtFld.resignFirstResponder()
    }
}

extension AddItemViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(units[row])
        self.unitTxtFld.text = units[row]
    }
}
