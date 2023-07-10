//
//  CharactersTableVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit
import CoreData
import Moya

class CharactersTableVC: UIViewController, NSFetchedResultsControllerDelegate {
    
//    private static var data1: [Character] = [
//        Character(id: 1, name: "Morti", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "morty1"),
//        Character(id: 2, name: "Morti2", status: Character.Status.alive, species: "Human", gender: Character.Gender.male, location: "Earth", image: "morty2")
//    ]
    
    
    let userInteractiveQueue = DispatchQueue.main
    lazy var frc: NSFetchedResultsController<RaMCharacter> = {
        let request = RaMCharacter.fetchRequest()
        request.sortDescriptors = []
        let frc = NSFetchedResultsController(fetchRequest: request,
            managedObjectContext: PersistentContainer.shared.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        frc.delegate = self
        return frc
    }()
    
    private let manager: NetworkManagerProtocol = NetworkManger()
    //private static var characters: [CharacterResponseModel] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            try frc.performFetch()
        }catch{
            print(error)
        }
        
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        manager.fetchCharacters { result in
            switch result {
                
            case let .success(response):
                
                self.userInteractiveQueue.async {
                    // here delete
                    let fetchRequest: NSFetchRequest<RaMCharacter> = RaMCharacter.fetchRequest()
                    do {
                        let objects = try PersistentContainer.shared.viewContext.fetch(fetchRequest)
                        for object in objects {
                            PersistentContainer.shared.viewContext.delete(object)
                        }
                        try PersistentContainer.shared.viewContext.save()
                    } catch {
                        print("Error deleting")
                    }
                    //CharactersTableVC.characters = response.results
                    for result in response.results{
                        let character = RaMCharacter(context: PersistentContainer.shared.viewContext)
                        character.name = result.name
                        character.status = result.status
                        character.location = result.location.name
                        character.species = result.species
                        character.gender = result.gender
                        character.image = result.image
                        PersistentContainer.shared.saveContext()
                        
                    }
                    self.tableView.reloadData()  // and update table view
                }
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    
    
    
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? CharacterInfoVC {
            destVC.character = sender as? RaMCharacter
            destVC.delegate = self
        }
    }
    
    
    
}


extension CharactersTableVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return CharactersTableVC.characters.count
        if let sections = frc.sections{
            return sections[section].numberOfObjects
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell") as? CharacterTableViewCell
        else { return UITableViewCell() }
        print(indexPath)
        
        characterCell.setUpData(frc.object(at: indexPath))
        
        
        
        return characterCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var character: RaMCharacter = frc.object(at: indexPath)
        performSegue(withIdentifier: "ToCharacterInfoVC", sender: character)
    }

    
}


extension CharactersTableVC: CharacterInfoDelegate {
    func characterInfoDidUpdate(_ character: CharacterResponseModel) {
        // updateSomeCharacter(character)
        tableView.reloadData()
    }
}
