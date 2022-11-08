//
//  PokemonDetailPresenter.swift
//  CaseApp
//
//  Created by Tolga Polat on 7.11.2022.
//

import Foundation

protocol pDetailPresenter {
    var detailRouter : pDetailRouter? {get set}
    var detailInteractor : pDetailInteractor? {get set}
    var detailView : pDetailViewController? {get set}
    
    func interactorDownloadDetailPokemons(result: Result<PokemonDetailResponse?, Error>)
}

class PokemonDetailPresenter: pDetailPresenter {
    var detailRouter: pDetailRouter?
    var detailInteractor: pDetailInteractor? {
        didSet{
            detailInteractor?.downloadDetailPokemon()
        }
        //burdaki değer atanınca yapılacak işlemler
    }
    var detailView: pDetailViewController?
    func interactorDownloadDetailPokemons(result: Result<PokemonDetailResponse?, Error>) {
        switch result {
        case .success(let pokemonDetail):
            guard let pokemonDetail = pokemonDetail
            else {
                // TODO: Error handling
                return
            }
            guard let pokemonAbility = pokemonDetail.abilities,pokemonAbility .isEmpty == false,let ability = pokemonAbility[0].ability?.name else{
                detailView?.update(with: "Try again later...")
                return
            }
            guard let pokemonSprites = pokemonDetail.sprites, let sprites = pokemonSprites.back_default else {
                detailView?.update(with: "Try again later...")
                return
            }
            detailView?.update(with: ability, imgUrl: sprites)
            print("update")
        case .failure(let error):
            detailView?.update(with: "Try again later...")
            print("update")
            
        }
    }
}
