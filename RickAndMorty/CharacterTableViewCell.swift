//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit



final class CharacterTableViewCell: UITableViewCell {

    @IBOutlet weak var characterName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(_ data: RaMCharacter) {
        self.characterName.text = data.name
    }
    
    
}
