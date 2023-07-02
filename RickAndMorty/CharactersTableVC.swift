//
//  CharactersTableVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit

class CharactersTableVC: UIViewController {
    
    private var data: [Character] = [
        Character(id: 1, name: "Morti", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "-"),
        Character(id: 2, name: "Morti2", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "-")
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
    }
}


extension CharactersTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell() }
        
        characterCell.setUpData(data[indexPath.row])
        
        
        
        return characterCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var character: Character = data[indexPath.row]
        performSegue(withIdentifier: "ToCharacterInfoVC", sender: character)
    }

    
}
