//
//  ViewController.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 20.05.2021.
//

import UIKit

class LibraryViewController: UIViewController, BindableType {

    var viewModel: LibraryViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
    }

}

