//
//  AddItemViewController + UIPickerViewDelegate.swift
//  Shopping list
//
//  Created by Виктор Петровский on 01.12.2020.
//

import UIKit

extension AddItemViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(raitingValues[row])"
    }
}
