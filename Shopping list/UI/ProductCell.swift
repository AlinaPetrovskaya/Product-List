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
//        let multipluer =
//        raitingColor.widthAnchor.constraint(equalTo: raitingStars.widthAnchor, multiplier: CGFloat(multipluer)).isActive = true
    }
    
    private func updateUI() {
        contentCellView.layer.cornerRadius = contentCellView.frame.height / 10
    }
}
