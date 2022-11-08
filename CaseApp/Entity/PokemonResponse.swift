//
//  PokemonResponse.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation

struct PokemonResponse: Decodable {
    let count: Int?
    let next: URL?
    let previous: String?
    let results: [Pokemon]?
}
