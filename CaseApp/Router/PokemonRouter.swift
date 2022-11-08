//
//  PokemonRouter.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation
import UIKit

typealias EntryPoint = pViewController & UIViewController
protocol pRouter {
    var entry : EntryPoint? { get }
    static func startExecution() -> pRouter
}

class PokemonRouter : pRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> pRouter {
        
        let router = PokemonRouter()
        
        var view : pViewController = PokemonViewController()
        var presenter : pPresenter = PokemonPresenter()
        var interactor : pInteractor = PokemonInteractor()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        router.entry = view as? EntryPoint
        
        return router
        
    }
    
    
}
