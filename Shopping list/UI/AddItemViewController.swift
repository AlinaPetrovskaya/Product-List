//
//  AddItemViewController.swift
//  Shopping list
//
//  Created by Виктор Петровский on 29.11.2020.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var raitingValue: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
    @IBAction func saveDataPressed(_ sender: UIButton) {
        DataShoppingList.arrayOfProducts.append(ModelShoppingList(name: nameTextField.text ?? "No name", description: descriptionTextField.text ?? "", raiting: 0))
        
        dismiss(animated: true, completion: nil)
    }
    
}
