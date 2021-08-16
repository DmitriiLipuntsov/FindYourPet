//
//  ViewController.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 20.05.2021.
//

import UIKit
import RxSwift
import RxDataSources
import Kingfisher

class LibraryViewController: UIViewController, BindableType {

    var viewModel: LibraryViewModel!
    
    private let disposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<BreedSection>!
    
    private var collectionView: UICollectionView!
    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 0,
        bottom: 50.0,
        right: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Library"

        createTableView()
        createTestButton()
    }
    
    //MARK: - TestButton
    var buttonTest: UIButton!
    func createTestButton() {
        buttonTest = UIButton(type: .system)
        buttonTest.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        buttonTest.backgroundColor = .red
        view.addSubview(buttonTest)
        
        buttonTest.addTarget(self, action: #selector(testButtonTupped), for: .touchUpInside)
    }
    
    @objc func testButtonTupped() {
        
        
    }
    
    func bindViewModel() {
        viewModel.listOfBreed
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func createTableView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.center = self.view.center
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        
        collectionView.register(
            BreedCollectionViewCell.self,
            forCellWithReuseIdentifier: BreedCollectionViewCell.cellIdentifier)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<BreedSection> { dataSource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.cellIdentifier, for: indexPath) as? BreedCollectionViewCell else { return UICollectionViewCell() }
            cell.breedNameLabel.text = item.title
            if let sourceImage = item.thumbnail?.source {
                cell.breedImageView.kf.setImage(with: URL(string: sourceImage), placeholder: UIImage(named: "unknownDog"))
            }
            return cell
        }

        
        self.dataSource = dataSource
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
}

//MARK: - UITableViewDelegate
extension LibraryViewController: UICollectionViewDelegate {
    
    
    
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 20, height: view.bounds.height - view.bounds.height / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
