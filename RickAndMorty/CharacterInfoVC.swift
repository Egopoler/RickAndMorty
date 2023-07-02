//
//  CharacterInfoVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit
protocol CharacterInfoDelegate: AnyObject {
    func characterInfoDidUpdate(_ character: Character)
}
class CharacterInfoVC: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: CharacterInfoDelegate?
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
        
        if let filePath = Bundle.main.path(forResource: realCharacter.image, ofType: "png") {
            let fileURL = URL(fileURLWithPath: filePath)
            let image = UIImage(contentsOfFile: fileURL.path)
            characterImage.image = image
        }
        
        
        
        
        
    }
    

    
    @IBAction func NameWasChanged(_ sender: UITextField) {
        
        guard let realCharacter = character else
        { return }
        
        
        
        let newCharacter = Character(id: realCharacter.id, name: nameTextField.text!, status: realCharacter.status, species: realCharacter.species, gender: realCharacter.gender, location: locationTextField.text!, image: realCharacter.image)
        
        
        guard let characterTableVC = storyboard?.instantiateViewController(withIdentifier: "CharactersTableVC") as? CharactersTableVC else
        {
            print("error")
            return
        }
        
        characterTableVC.updateSomeCharacter(newCharacter)
        delegate?.characterInfoDidUpdate(newCharacter)
    }
    
    @IBAction func LocationWasChanged(_ sender: UITextField) {
        guard let realCharacter = character else
        { return }
        
        
        
        let newCharacter = Character(id: realCharacter.id, name: nameTextField.text!, status: realCharacter.status, species: realCharacter.species, gender: realCharacter.gender, location: locationTextField.text!, image: realCharacter.image)
        
        
        guard let characterTableVC = storyboard?.instantiateViewController(withIdentifier: "CharactersTableVC") as? CharactersTableVC else
        {
            print("error")
            return
        }
        
        characterTableVC.updateSomeCharacter(newCharacter)
        delegate?.characterInfoDidUpdate(newCharacter)
    }
    
    
}
