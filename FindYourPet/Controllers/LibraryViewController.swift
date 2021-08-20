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
    
    //MARK: - Properties
    var viewModel: LibraryViewModel!
    
    private let disposeBag = DisposeBag()
    private var dataSource: RxCollectionViewSectionedReloadDataSource<BreedSection>!
    
    private var searchController: UISearchController!
    private var activityIndicator: UIActivityIndicatorView!
    private var collectionView: UICollectionView!
    private let sectionInsets = UIEdgeInsets(
        top: 10.0,
        left: 20,
        bottom: 50.0,
        right: 20)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Library"
        
        createSearchBar()
        createCollectionView()
        createActivityIndicator()
        createTestButton()
    }
    
    //MARK: - TestButton
    var buttonTest: UIButton!
    func createTestButton() {
        buttonTest = UIButton(type: .system)
        buttonTest.frame = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 100, height: 100)
        buttonTest.backgroundColor = .red
        //        view.addSubview(buttonTest)
        
        buttonTest.addTarget(self, action: #selector(testButtonTupped), for: .touchUpInside)
    }
    
    @objc func testButtonTupped() {
        
        
        
    }
    
    //MARK: - BindViewModel
    func bindViewModel() {
        viewModel.searchBreed
            .do(onNext: { [weak self] breeds in
                guard breeds.first?.items != [] else { return }
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                }
            })
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    //MARK: - CreateSearchBar
    private func createSearchBar() {
        searchController = UISearchController()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: - CreateActivityIndicator
    private func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    //MARK: - CreateCollectionView
    private func createCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        collectionView.center = self.view.center
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        
        collectionView.register(
            BreedCollectionViewCell.self,
            forCellWithReuseIdentifier: BreedCollectionViewCell.cellIdentifier)
        
        self.dataSource = getDataSource()
        
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

//MARK: - UISearchBarDelegate
extension LibraryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSortedBreeds(with: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCencelButtonTapped()
    }
}

//MARK: - ConfigureDataSource
extension LibraryViewController {
    private func getDataSource() -> RxCollectionViewSectionedReloadDataSource<BreedSection> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<BreedSection> { dataSource, collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedCollectionViewCell.cellIdentifier, for: indexPath) as? BreedCollectionViewCell else { return UICollectionViewCell() }
            cell.breedNameLabel.text = item.title
            if item.title == "Paisley Terrier" {
                print(item.title)
                print(item.thumbnail)
            }
            if let sourceImage = item.thumbnail?.source {
                cell.breedImageView.kf.setImage(with: URL(string: sourceImage), placeholder: UIImage(named: "unknownDog"))
            }
            return cell
        }
        
        return dataSource
    }
}

//MARK: - UITableViewDelegate
extension LibraryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        do {
            guard let breed = try dataSource.model(at: indexPath) as? Breed else { return }
            viewModel.actionForCellSelected(breedItem: breed)
        } catch {
            fatalError("Model not found.")
        }


    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width - 250, height: view.bounds.height / 2 - 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
