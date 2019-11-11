//
//  CharacterListTableViewCell.swift
//  Marvel MVVMC
//
//  Created by Lewis McGrath on 08/11/2019.
//  Copyright © 2019 Lewis McGrath. All rights reserved.
//

import UIKit

class CharacterListTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.text = "Thor"
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .brown
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(characterLabel)
        cellView.addSubview(characterImageView)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            characterImageView.heightAnchor.constraint(equalToConstant: 60),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            characterImageView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            characterLabel.heightAnchor.constraint(equalToConstant: 75),
            characterLabel.widthAnchor.constraint(equalToConstant: 200),
            characterLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            characterLabel.leftAnchor.constraint(equalTo: characterImageView.rightAnchor, constant: 20),
            
            
            
        ])
    }
    
}
