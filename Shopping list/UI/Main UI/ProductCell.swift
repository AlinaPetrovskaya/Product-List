//
//  ProductCell.swift
//  Shopping list
//
//  Created by Виктор Петровский on 28.11.2020.
//

import UIKit

class ProductCell: UITableViewCell {
    
    var raiting: Int = 5 {
        didSet {
            setRaiting(raiting: raiting)
        }
    }
    
    @IBOutlet weak var contentCellView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var raitingValue: UIProgressView!
    @IBOutlet weak var raitingStars: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    private func setRaiting (raiting: Int) {
        raitingValue.progress = ((Float(raiting) * 100) / 500)
    }
    
    private func updateUI() {
        contentCellView.layer.cornerRadius  = contentCellView.frame.height / 10
        contentCellView.layer.shadowColor   = UIColor.lightGray.cgColor
        contentCellView.layer.shadowOpacity = 1
        contentCellView.layer.shadowOffset  = .zero
        contentCellView.layer.shadowRadius  = 2
    }
}
