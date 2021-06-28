//
//  SceneCoordinator.swift
//  FindYourPet
//
//  Created by Михаил Липунцов on 22.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {

  private var window: UIWindow
  private var currentViewController: UIViewController

  required init(window: UIWindow) {
    self.window = window
    currentViewController = window.rootViewController ?? UIViewController()
  }

  static func actualViewController(for viewController: UIViewController) -> UIViewController {
    if let navigationController = viewController as? UINavigationController {
        return SceneCoordinator.actualViewController(for: navigationController.viewControllers.first!)
    } else if let tabBarController = viewController as? UITabBarController,
              let selectedViewController = tabBarController.selectedViewController {
        return SceneCoordinator.actualViewController(for: selectedViewController)
    } else {
        return viewController
    }
  }

  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Never> {
    let subject = PublishSubject<Void>()
    let viewController = scene.viewController()
    switch type {
      case .root:
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
        window.rootViewController = viewController
        subject.onCompleted()

      case .push:
        guard let navigationController = currentViewController.navigationController else {
          fatalError("Can't push a view controller without a current navigation controller")
        }
        _ = navigationController.rx.delegate
          .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
          .map { _ in }
          .bind(to: subject)
        navigationController.pushViewController(viewController, animated: true)
        currentViewController = SceneCoordinator.actualViewController(for: viewController)

      case .modal:
        viewController.modalPresentationStyle = .fullScreen
        currentViewController.present(viewController, animated: true) {
          subject.onCompleted()
        }
        currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
    return subject.asObservable()
        .take(1)
        .ignoreElements()
  }

  @discardableResult
  func pop(animated: Bool) -> Observable<Never> {
    let subject = PublishSubject<Void>()
    if let presenter = currentViewController.presentingViewController {
      currentViewController.dismiss(animated: animated) {
        self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
        subject.onCompleted()
      }
    } else if let navigationController = currentViewController.navigationController {
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      guard navigationController.popViewController(animated: animated) != nil else {
        fatalError("can't navigate back from \(currentViewController)")
      }
      currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
    } else {
      fatalError("Not a modal, no navigation controller: can't navigate back from \(currentViewController)")
    }
    return subject.asObservable()
      .take(1)
      .ignoreElements()
  }
}
