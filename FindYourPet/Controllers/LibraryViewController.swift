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
    
    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String,String>>!
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        createTableView()
    }
    
    func bindViewModel() {
        viewModel.listOfBreed
    }
    
    private func createTableView() {
        let tableView = UITableView()
        tableView.center = self.view.center
        view.addSubview(tableView)
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>> { [weak self] dataSource, tableView, indexPath, item in
            guard let self = self else { return UITableViewCell()}
            let cell = UITableViewCell()
            cell.textLabel?.text = ""
            return cell
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    

}

