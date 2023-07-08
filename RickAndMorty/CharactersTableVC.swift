//
//  CharactersTableVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit

import Moya

class CharactersTableVC: UIViewController {
    
//    private static var data1: [Character] = [
//        Character(id: 1, name: "Morti", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "morty1"),
//        Character(id: 2, name: "Morti2", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "morty2")
//    ]
    
    
    private let manager: NetworkManagerProtocol = NetworkManger()
    private static var characters: [CharacterResponseModel] = []
    

    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        manager.fetchCharacters { result in
            switch result {
            case let .success(response):
                CharactersTableVC.characters = response.results
                self.tableView.reloadData()  // and update table view
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? CharacterInfoVC {
            destVC.character = sender as? CharacterResponseModel
            destVC.delegate = self
        }
    }
    
    
    
}


extension CharactersTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CharactersTableVC.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell() }
        print(indexPath)
        
        characterCell.setUpData(CharactersTableVC.characters[indexPath.row])
        
        
        
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var character: CharacterResponseModel = CharactersTableVC.characters[indexPath.row]
        performSegue(withIdentifier: "ToCharacterInfoVC", sender: character)
    }

    
}


extension CharactersTableVC: CharacterInfoDelegate {
    func characterInfoDidUpdate(_ character: CharacterResponseModel) {
        // updateSomeCharacter(character)
        tableView.reloadData()
    }
}
