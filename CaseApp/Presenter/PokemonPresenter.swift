//
//  PokemonPresenter.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation


enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}
protocol pPresenter {
    //hem okunacak hem yazılacak
    var router : pRouter? { get set }
    var interactor : pInteractor? { get set }
    var view : pViewController? { get set }
       
    func interactorDownloadPokemons(result: Result<[Pokemon]?, Error>)
}

class PokemonPresenter : pPresenter {
    
    var router: pRouter?
    var interactor: pInteractor? {
        didSet{
            interactor?.downloadPokemon()
        }
        //burdaki değer atanınca yapılacak işlemler
    }
    var view: pViewController?
    
    
    func interactorDownloadPokemons(result: Result<[Pokemon]?, Error>) {
        switch result {
        case .success(let pokemons):
            guard let pokemons = pokemons,
                  !pokemons.isEmpty else {
                // TODO: Error handling
                return
            }
            view?.update(with: pokemons)
            print("update")
        case .failure(let error):
            view?.update(with: "Try again later...")
            print("update")
            
        }
    }
}

