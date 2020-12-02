//
//  AddItemViewController.swift
//  Shopping list
//
//  Created by Виктор Петровский on 29.11.2020.
//

import UIKit

class AddItemViewController: UIViewController {
    
    public var callback: ((String, String, Int) -> ())?
    var raitingValues = [1, 2, 3, 4, 5]
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var raitingPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        raitingPicker.dataSource = self
        raitingPicker.delegate = self
        
        updateUI()
    }
    
    @IBAction func saveDataPressed(_ sender: UIButton) {
        let raitingValue = raitingValues[raitingPicker.selectedRow(inComponent: 0)]
        
        guard let nameText = nameTextField.text, let descriptionText = descriptionTextField.text else { return }
        
        let name = nameText == "" ? "No value" : nameText
        callback?(name, descriptionText, raitingValue)
        
        dismiss(animated: true, completion: nil)
    }
    
    private func updateUI() {
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
    
}
