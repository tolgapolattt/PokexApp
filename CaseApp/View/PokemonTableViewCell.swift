//
//  PokemonTableViewCell.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import UIKit
import SnapKit

class PokemonTableViewCell : UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
    }
}

















































