//
//  CharacterListViewController.swift
//  Marvel MVVMC
//
//  Created by Lewis McGrath on 07/11/2019.
//  Copyright © 2019 Lewis McGrath. All rights reserved.
//

import UIKit

class CharacterListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var listOfCharacters = [CharacterDetail]()
    
    let characterListService = CharacterListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        characterListService.getCharacterDataResponse(completion: { [weak self] response in
            self?.listOfCharacters = response.data.results
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        })
    }
    
    let tableview: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.separatorColor = .white
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    func setupTableView() {
        tableview.register(CharacterListTableViewCell.self, forCellReuseIdentifier: "cellId")
        tableview.delegate = self
        tableview.dataSource = self
        
        view.addSubview(tableview)
        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CharacterListTableViewCell
        cell.backgroundColor = UIColor.white
       

        cell.characterLabel.text = listOfCharacters[indexPath.row].name
    //    cell.characterImage.image = characterImage[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
