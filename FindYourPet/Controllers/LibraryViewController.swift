//
//  ViewController.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 20.05.2021.
//

import UIKit
import RxSwift
import RxDataSources

class LibraryViewController: UIViewController, BindableType {

    var viewModel: LibraryViewModel!
    
    private let disposeBag = DisposeBag()
    private var dataSource: RxTableViewSectionedReloadDataSource<BreedSection>!
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Library"

        createTableView()
    }
    
    func bindViewModel() {
        viewModel.listOfBreed
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func createTableView() {
        tableView = UITableView()
        tableView.center = self.view.center
        view.addSubview(tableView)
        
        let dataSource = RxTableViewSectionedReloadDataSource<BreedSection> { dataSource, tableView, indexPath, item in
            let cell = UITableViewCell()
            cell.textLabel?.text = item
            return cell
        }
        
        self.dataSource = dataSource
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    

}

//MARK: - UITableViewDelegate
extension LibraryViewController: UITableViewDelegate {
    
    
    
}
