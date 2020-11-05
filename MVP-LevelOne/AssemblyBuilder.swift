//
//  ModuleBuilder.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 28.09.2020.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router:RouterProtocol) -> UIViewController
    func createDetailModule(comment:Comment?, router:RouterProtocol) -> UIViewController
}

class AssemblyBuilder:AssemblyBuilderProtocol {
    func createDetailModule(comment: Comment?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, comment: comment)
        view.presenter = presenter
        return view
        
    }
    
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = ViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view,networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
}
