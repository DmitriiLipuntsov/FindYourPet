//
//  BreedCollectionViewCell.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 15.08.2021.
//

import UIKit

class BreedCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "cellForBreed"
    
    var breedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isOpaque = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var breedNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Breed name"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.isOpaque = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        backgroundColor = #colorLiteral(red: 0.9466126561, green: 0.9409852624, blue: 0.9509382844, alpha: 1)
        clipsToBounds = true
        layer.cornerRadius = 20
        
        addSubview(breedImageView)
        addSubview(breedNameLabel)
        
        setConstraints()
    }
    
    
    
    func setConstraints() {
        // breedImageView
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            breedImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            breedImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            breedImageView.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.5)
        ])
        
        // breedNameLabel
        NSLayoutConstraint.activate([
            breedNameLabel.topAnchor.constraint(equalTo: breedImageView.bottomAnchor, constant: 10),
            breedNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            breedNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
}
