//
//  PokemonDetailInteractor.swift
//  CaseApp
//
//  Created by Tolga Polat on 7.11.2022.
//

import Foundation


protocol pDetailInteractor {
    var detailPresenter : pDetailPresenter? {get set}
    var url : String? {get set}
    func downloadDetailPokemon()
}

class PokemonDetailInteractor : pDetailInteractor{
    var detailPresenter: pDetailPresenter?
    var url: String?
    
    func downloadDetailPokemon() {
        guard let url = URL(string: self.url ?? "")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.detailPresenter?.interactorDownloadDetailPokemons(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let pokemons = try JSONDecoder().decode(PokemonDetailResponse.self, from: data)
                self?.detailPresenter?.interactorDownloadDetailPokemons(result: .success(pokemons))
            } catch {
                self?.detailPresenter?.interactorDownloadDetailPokemons(result: .failure(NetworkError.ParsingFailed))
            }
            
        }
        task.resume()
    }
    
}
