//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit

struct Character {
    enum Status {
        case alive
        case dead
        case unknown
    }
    
    enum Gender {
        case female
        case male
        case genderless
        case unknown
    }

    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: Gender
    let location: String
    let image: String
}


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
    
    func setUpData(_ data: Character) {
        self.characterName.text = data.name
    }
    
    
}
