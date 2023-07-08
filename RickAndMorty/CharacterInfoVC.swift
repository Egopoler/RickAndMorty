//
//  CharacterInfoVC.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 01.07.2023.
//

import UIKit


protocol CharacterInfoDelegate: AnyObject {
    func characterInfoDidUpdate(_ character: CharacterResponseModel)
}
class CharacterInfoVC: UIViewController {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    weak var delegate: CharacterInfoDelegate?
    var character: CharacterResponseModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let realCharacter = character else { return }
        
        nameTextField.text = realCharacter.name
        genderLabel.text = realCharacter.gender
        locationTextField.text = realCharacter.location.name
        statusLabel.text = realCharacter.status
        speciesLabel.text = realCharacter.species

        // Assuming that you are receiving a URL string for the image
        if let imageUrl = URL(string: realCharacter.image) {
            DispatchQueue.global(qos: .background).async {
                if let imageUrl = URL(string: realCharacter.image) {
                    self.downloadImage(from: imageUrl)
                } else {
                    print("Invalid URL for the image")
                }
            }
        } else {
            print("Invalid URL for the image")
        }
    }
    
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                let downloadedImage = UIImage(data: data)
                self.characterImage.image = downloadedImage
            }
        }.resume()
    }
    
    
}
