//
//  AddItemViewController + UIPickerViewDataSource.swift
//  Shopping list
//
//  Created by Виктор Петровский on 01.12.2020.
//

import UIKit

extension AddItemViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return raitingValues.count
    }
}
