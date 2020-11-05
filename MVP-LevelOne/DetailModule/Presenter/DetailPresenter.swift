//
//  DetailPresenter.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 29.09.2020.
//

import Foundation

protocol DetailViewProtocol:class {
    func setComment(comment:Comment?)
}


protocol DetailViewPresenterProtocol:class {
    init(view:DetailViewProtocol, networkService:NetworkServiceProtocol,
         router:RouterProtocol,
         comment:Comment?)
    func setComment()
    func tap()
    
}

class DetailPresenter:DetailViewPresenterProtocol {
   
    
   
    weak var view:DetailViewProtocol?
    let networkService:NetworkServiceProtocol!
    var comment:Comment?
    var router:RouterProtocol?
    
    
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?) {
        self.networkService = networkService
        self.view = view
        self.comment = comment
        self.router = router
    }
    
  public  func setComment() {
    self.view?.setComment(comment: comment)
    }
    
    func tap() {
        router?.popToRoot()
    }
    
}
