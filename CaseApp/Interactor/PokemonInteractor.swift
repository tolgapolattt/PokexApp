//
//  PokemonInteractor.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation
import UIKit

protocol pInteractor {
    var presenter : pPresenter? {get set}
    
    func downloadPokemon()
}
class PokemonInteractor : pInteractor {
    
    var presenter: pPresenter?
    
    func downloadPokemon() {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDownloadPokemons(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let pokemons = try JSONDecoder().decode(PokemonResponse.self, from: data)
                self?.presenter?.interactorDownloadPokemons(result: .success(pokemons.results))
            } catch {
                self?.presenter?.interactorDownloadPokemons(result: .failure(NetworkError.ParsingFailed))
            }
            
        }
        task.resume()
    }
}



