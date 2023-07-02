//
//  CharactersTableVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit

class CharactersTableVC: UIViewController {
    
    private static var data: [Character] = [
        Character(id: 1, name: "Morti", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "morty1"),
        Character(id: 2, name: "Morti2", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "morty2")
    ]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! CharacterInfoVC
        destVC.character = sender as? Character
        print(CharactersTableVC.data[0].name)
    }
    
    
    // replace all characters with some ID with new one
    func updateSomeCharacter(_ newCharacter: Character) {
        
        for i in 0..<CharactersTableVC.data.count {
            if newCharacter.id == CharactersTableVC.data[i].id {
                CharactersTableVC.data[i] = newCharacter
            }
        }
    }
    
}


extension CharactersTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CharactersTableVC.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell() }
        print(indexPath)
        
        characterCell.setUpData(CharactersTableVC.data[indexPath.row])
        
        
        
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var character: Character = CharactersTableVC.data[indexPath.row]
        performSegue(withIdentifier: "ToCharacterInfoVC", sender: character)
    }

    
}
