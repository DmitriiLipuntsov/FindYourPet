//
//  DescriptionBreedViewController.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 17.08.2021.
//

import UIKit
import Kingfisher

class DescriptionBreedViewController: UIViewController, BindableType {
    
    var viewModel: DescriptionBreedViewModel!
    
    var breedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isOpaque = true
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentMode = .bottom
        return scrollView
    }()
    
    var breedNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.isOpaque = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.isOpaque = false
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(breedImageView)
        view.addSubview(breedNameLabel)
        view.addSubview(scrollView)
        scrollView.addSubview(descriptionLabel)
        
        scrollView.contentSize = CGSize(
            width: view.frame.width - 60,
            height: breedNameLabel.frame.height)

        setConstraints()
    }
    
    func bindViewModel() {
        let breed = viewModel.breedItem
        if let sourceImage = breed.thumbnail?.source {
            breedImageView.kf.setImage(with: URL(string: sourceImage), placeholder: UIImage(named: "unknownDog"))
        }
        
        breedNameLabel.text = breed.title
        descriptionLabel.text = breed.extract
    }
}

//MARK: - Configure constraints
extension DescriptionBreedViewController {
    func setConstraints() {
        // breedImageView
        NSLayoutConstraint.activate([
            breedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            breedImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            breedImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            breedImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        // breedNameLabel
        NSLayoutConstraint.activate([
            breedNameLabel.topAnchor.constraint(equalTo: breedImageView.bottomAnchor, constant: 30),
            breedNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            breedNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        ])
        
        // scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: breedNameLabel.bottomAnchor, constant: 30),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
        // descriptionLabel
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
}
