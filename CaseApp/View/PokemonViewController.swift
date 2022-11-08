//
//  PokemonViewController.swift
//  CaseApp
//
//  Created by Tolga Polat on 6.11.2022.
//

import Foundation
import UIKit

protocol pViewController {
    var presenter : pPresenter? {get set}
    func update(with pokemons: [Pokemon])
    func update(with error: String)
    var pokemonImageRequest : PokemonSpritesEntity!{get set}
}

class PokemonViewController : UIViewController, pViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var pokemonImageRequest: PokemonSpritesEntity!
    var presenter: pPresenter?
    var pokemonsList : [Pokemon] = []
    
    
    //MARK: -UI Elements
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    private let messageLabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 25, width: 200, height: 50)
    }
    // MARK: - Functions
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("PokemonTableViewCell", owner: self, options: nil)?.first as! PokemonTableViewCell
        cell.pokemonName.text = pokemonsList[indexPath.row].name
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("basıldı")
        
        let routerInstance = PokemonDetailRouter.startExecution(mdl: pokemonsList[indexPath.row])
        guard let detailVC = routerInstance.entry else { return  }
        // detailVC.requestModel = pokemonsList[indexPath.row]
        self.present(detailVC, animated: true, completion: nil)
        
    }
    
    func update(with pokemons: [Pokemon]) {
        DispatchQueue.main.async {
            self.pokemonsList = pokemons
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.pokemonsList = []
            self.tableView.isHidden = true
            self.messageLabel.text = error
            self.messageLabel.isHidden = false
            
        }
    }
}

