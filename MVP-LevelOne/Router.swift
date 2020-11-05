//
//  RouterProcol.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 01.10.2020.
//

import UIKit

protocol RouterMain {
    var navigationController:UINavigationController? {get set}
    var asamblyBuilder: AssemblyBuilderProtocol? { get set }
}


protocol RouterProtocol:RouterMain {
    func initialVC ()
    func showDeteil(comment:Comment?)
    func popToRoot()
}


class Router:RouterProtocol {
    
    
    var navigationController: UINavigationController?
    
    var asamblyBuilder: AssemblyBuilderProtocol?
    
    
    //DI
    init(navigation:UINavigationController, assemblyBuilder:AssemblyBuilderProtocol) {
        self.asamblyBuilder = assemblyBuilder
        self.navigationController = navigation
    }
    
    
    func initialVC() {
        if let navController = navigationController {
            guard let mainViewController = asamblyBuilder?.createMainModule(router: self) else {return }
            
            navController.viewControllers = [mainViewController]
        }
        
      
    }
    
    func showDeteil(comment: Comment?) {
        if let navController = navigationController {
            guard let detailViewController = asamblyBuilder?.createDetailModule(comment: comment, router: self) else {return }
            navController.pushViewController(detailViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navController = navigationController {
            navController.popToRootViewController(animated: true)
        }
    }
    
 
    
    
}
