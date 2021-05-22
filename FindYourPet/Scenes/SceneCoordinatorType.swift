//
//  SceneCoordinatorType.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 20.05.2021.
//

import UIKit
import RxSwift

protocol SceneCoordinatorType {
    
  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Never>

  @discardableResult
  func pop(animated: Bool) -> Observable<Never>
    
}

extension SceneCoordinatorType {
  @discardableResult
  func pop() -> Observable<Never> {
    return pop(animated: true)
  }
}
