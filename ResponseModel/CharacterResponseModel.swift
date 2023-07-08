//
//  CharacterResponseModel.swift
//  RickAndMorty
//
//  Created by MacBook Pro on 08.07.2023.
//

import Foundation

struct CharacterResponseModel: Codable {
    enum Status: String, Codable {
        case alive = "alive"
        case dead = "dead"
        case unknown = "unknown"
    }
    
    enum Gender: String, Codable {
        case female = "female"
        case male = "male"
        case genderless = "genderless"
        case unknown = "unknown"
    }

    let id: Int
    let name: String
    let status: Status
    let species: String
    let gender: Gender
    let location: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
            case id, name, status, species, location, gender, image
        }
}
