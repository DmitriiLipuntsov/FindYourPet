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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        addSubview(breedImageView)
        addSubview(breedNameLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        // breedImageView
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            breedImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            breedImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            breedImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // breedNameLabel
        NSLayoutConstraint.activate([
            breedNameLabel.topAnchor.constraint(equalTo: breedImageView.bottomAnchor, constant: 20),
            breedNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            breedNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
}
