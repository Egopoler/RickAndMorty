//
//  CharacterInfoVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit

class CharacterInfoVC: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    var character: Character?
    override func viewDidLoad() {
        super.viewDidLoad()
        let realCharacter = character ?? Character(id: -1, name: "Anonim", status: Character.Status.unknown, species: "unknown", gender: Character.Gender.unknown, location: "unknowm", image: "")
        
        // Do any additional setup after loading the view.
        
        nameTextField.text = realCharacter.name
        
        switch realCharacter.gender {
        case .male:
            genderLabel.text = "Male"
        case .female:
            genderLabel.text = "Female"
        case .genderless:
            genderLabel.text = "Genderless"
        case .unknown:
            genderLabel.text = "Unknown"
        }
        
        locationTextField.text = realCharacter.location
        
        switch realCharacter.status {
        case .alive:
            statusLabel.text = "Alive"
        case .dead:
            statusLabel.text = "Dead"
        case .unknown:
            statusLabel.text = "Unknown"
        }
        
        speciesLabel.text = realCharacter.species
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
