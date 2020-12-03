//
//  AddItemViewController.swift
//  Shopping list
//
//  Created by Виктор Петровский on 29.11.2020.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    public var callback: ((String, String, Int) -> ())?
    private var raitingValues = [1, 2, 3, 4, 5]
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var raitingPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        raitingPicker.dataSource = self
        raitingPicker.delegate   = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector (self.hideKeyboard (_:)))
        let tapMain = UITapGestureRecognizer(target: self, action: #selector (self.tapMainView (_:)))
        self.contentView.addGestureRecognizer(tap)
        self.mainView.addGestureRecognizer(tapMain)
        updateUI()
    }
    
    @objc func hideKeyboard(_ sender:UITapGestureRecognizer) {
        nameTextField.endEditing(true)
        descriptionTextField.endEditing(true)
    }
    
    @objc func tapMainView(_ sender:UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
    
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return raitingValues.count
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(raitingValues[row])"
    }
}
