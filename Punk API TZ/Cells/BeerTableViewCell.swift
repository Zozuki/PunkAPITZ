//
//  BeerCell.swift
//  Punk API TZ
//
//  Created by user on 22.06.2021.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor =  UIColor.init(patternImage: UIImage(named: "stone3")!)
        
        self.beerImage.layer.cornerRadius = 28
        beerName.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.4)
        beerName.textAlignment = .center
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(text: String?, image: UIImage?) {
        beerImage.image = image
        beerName.text = text
    }
}

