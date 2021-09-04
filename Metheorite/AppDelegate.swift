//
//  AppDelegate.swift
//  Metheorite
//
//  Created by Vajda Kristóf on 2021. 09. 04..
//

import UIKit
import Core
import Domain
import RxSwift
import Resolver

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootCoordinator: RootCoordinator!
    
    let bag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator = RootCoordinator(window: window!)
        rootCoordinator.start()

        return true
    }

}
