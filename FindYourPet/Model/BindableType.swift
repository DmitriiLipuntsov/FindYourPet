//
//  BindableType.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import UIKit
import RxSwift

protocol BindableType: AnyObject {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }

  func bindViewModel()
}

extension BindableType where Self: UIViewController {
  func bindViewModel(to model: Self.ViewModelType) {
    viewModel = model
    loadViewIfNeeded()
    bindViewModel()
  }
}
