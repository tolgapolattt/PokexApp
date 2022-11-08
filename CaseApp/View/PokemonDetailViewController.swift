//
//  PokemonDetailViewController.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation
import UIKit
import SnapKit


protocol pDetailViewController {
    var detailPresenter : pDetailPresenter? {get set}
    var detailInteractor : pDetailInteractor? {get set}
    func update(with abilityName: String?,imgUrl: URL?)
    func update(with error: String)
    var requestModel : Pokemon!{get set}
}


class PokemonDetailViewController : UIViewController, pDetailViewController {
    
    var detailPresenter: pDetailPresenter?
    var detailInteractor: pDetailInteractor?
    
    
    
    //MARK: -UI Elements
    var pokemonImageView = UIImageView()
    var pokemonName = UILabel()
    var pokemonAbilitys = UILabel()
    var requestModel : Pokemon!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        customizeView()
        view.backgroundColor = .orange
    }
    
    // MARK: - Functions
    func setView(){
        self.view.addSubview(pokemonImageView)
        self.view.addSubview(pokemonName)
        self.view.addSubview(pokemonAbilitys)
        print("geldi")
        
        pokemonImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(self.view.snp.width).multipliedBy(0.26)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.123)
        }
        pokemonName.snp.makeConstraints { (make) in
            make.top.equalTo(self.pokemonImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        pokemonAbilitys.snp.makeConstraints { (make) in
            make.top.equalTo(self.pokemonName.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
    }
    func customizeView(){
        pokemonImageView.contentMode = .scaleToFill
        pokemonImageView.layer.masksToBounds = true
        pokemonImageView.image = UIImage(named: "cap")
        
        pokemonName.font = UIFont(name: "PingFangSC-RegularBold", size: 20)
        pokemonName.textColor = .black
        pokemonName.textAlignment = .center
        
        
        pokemonAbilitys.font = UIFont(name: "PingFangSC-RegularBold", size: 20)
        pokemonAbilitys.textColor = .black
        pokemonAbilitys.textAlignment = .center
        
    }
    func update(with abilityName: String?,imgUrl: URL?) {
        DispatchQueue.main.async {
            self.pokemonAbilitys.text = abilityName
            if let imgUrl = imgUrl {
                self.pokemonImageView.downloaded(from: imgUrl)
            }
            self.pokemonName.text = self.requestModel.name
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.pokemonAbilitys.text = ""
            self.pokemonImageView.image = nil
            self.pokemonName.text = ""
        }
    }
    
}
