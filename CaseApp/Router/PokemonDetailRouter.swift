//
//  PokemonDetailRouter.swift
//  CaseApp
//
//  Created by Tolga Polat on 7.11.2022.
//

import Foundation
import UIKit

typealias DetailEntryPoint = pDetailViewController & UIViewController
protocol pDetailRouter {
    var entry : DetailEntryPoint? { get }
    static func startExecution(mdl: Pokemon) -> pDetailRouter
}

class PokemonDetailRouter : pDetailRouter {
    var entry: DetailEntryPoint?
    
    static func startExecution(mdl: Pokemon) -> pDetailRouter {
        //view,int kontrol etmek. tüm dosyaları start execu icinde çağırıcaz. nerden basladıgımızı ilk ne gösterdiğimizi belli edicez.
        
        let detailRouter = PokemonDetailRouter()
        
        var detailView : pDetailViewController = PokemonDetailViewController() as! pDetailViewController
        
        detailView.requestModel = mdl
        
        var detailPresenter : pDetailPresenter = PokemonDetailPresenter()
        var detailInteractor : pDetailInteractor = PokemonDetailInteractor()
        
        detailInteractor.url = mdl.url?.absoluteString
        
        detailView.detailPresenter = detailPresenter
        
        detailPresenter.detailView = detailView
        detailPresenter.detailRouter = detailRouter
        detailPresenter.detailInteractor = detailInteractor
        
        detailInteractor.detailPresenter = detailPresenter
        
        detailRouter.entry = detailView as? DetailEntryPoint
        
        return detailRouter
        
    }
    
    
}
