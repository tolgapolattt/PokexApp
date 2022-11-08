//
//  PokemonDetailResponse.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let abilities: [PokemonAbilityEntity]?
    let sprites: PokemonSpritesEntity?
}

// MARK: - AbilityElement
struct PokemonAbilityEntity: Decodable {
    let ability: PokemonSubAbilityEntity?
    let isHidden: Bool?
    let slot: Int?
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}
struct PokemonSpritesEntity: Decodable {
    let back_default : URL?
}

// MARK: - AbilityAbility
struct PokemonSubAbilityEntity: Decodable {
    let name: String?
    let url: String?
}
