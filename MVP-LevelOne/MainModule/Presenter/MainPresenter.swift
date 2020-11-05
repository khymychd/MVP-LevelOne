//
//  MainPresenter.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 28.09.2020.
//

import Foundation


protocol MainViewProtocol:class {
  
    func succes()
    func failure(_ error:Error)
  
    
}


protocol MainViewPresenter:class {
    init (view:MainViewProtocol,
          networkService:NetworkServiceProtocol,
          router:RouterProtocol)

    func getcomments()
    
    var comments:[Comment]? {get set}
    
    func tapOnTheComment(comment:Comment?)
}


class MainPresenter:MainViewPresenter {
   
    var comments: [Comment]?
    weak var view:MainViewProtocol?
    let networkService:NetworkServiceProtocol!
    var router:RouterProtocol?
    
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.networkService = networkService
        self.view = view
        self.router = router
        getcomments()
    }
    
    func getcomments() {
        networkService.getComments { [weak self] (result) in
            guard let self = self else {return}
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error)
                }
            }
            
        }
    }
  
    func tapOnTheComment(comment:Comment?){
        router?.showDeteil(comment: comment)
    }
    

}
