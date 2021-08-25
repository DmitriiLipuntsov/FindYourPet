//
//  BreedCollectionViewCell.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 15.08.2021.
//

import UIKit
import Kingfisher

class BreedCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "cellForBreed"
    
    private var breedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "unknownDog")
        imageView.isOpaque = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var breedNameLabel: UILabel = {
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
    
    func configure(for breed: Breed) {
        if let sourceImage = breed.thumbnail?.source, let url = URL(string: sourceImage) {
            breedImageView.kf.setImage(with: url)
        } else {
            print("Source image for breed: \(breed.title) not found")
        }
        
        breedNameLabel.text = breed.title
        
    }
    
    override func prepareForReuse() {
        breedImageView.image = UIImage(named: "unknownDog")
        breedNameLabel.text = "Breed name"
        super.prepareForReuse()
    }
    
    private func setConstraints() {
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
