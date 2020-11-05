//
//  MainPresenterTest.swift
//  MVP-LevelOneTests
//
//  Created by Dima Khymych on 29.09.2020.
//

import XCTest

@testable import MVP_LevelOne

class MockView: MainViewProtocol {
    func succes() {
    }
    
    func failure(_ error: Error) {
    }
    
    
}


class MockNetworkService:NetworkServiceProtocol {
    
    var comments:[Comment]!
    
    init() {}
    
    convenience init(comments:[Comment]?) {
        self.init()
        self.comments = comments
    }
    
    func getComments(_ completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        }else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    
}


class MainPresenterTest: XCTestCase {

    var view:MockView!
    var presenter:MainPresenter!
    var networkService:NetworkServiceProtocol!
    var router:RouterProtocol!
    var comments = [Comment]()
    
    override func setUpWithError() throws {
        
        let nav = UINavigationController()
        let assembly = AssemblyBuilder()
        router = Router(navigation: nav,
                        assemblyBuilder: assembly)
        
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }

    func testGetSuccesComment() {
        let comment = Comment(postID: 1,
                              id: 2,
                              name: "Foo",
                              email: "Baz",
                              body: "Bar")
        
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService(comments: [comment])
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
      
        var catchComments:[Comment]?
        
        networkService.getComments { (result) in
            switch result{
            case .success(let comments):
            catchComments = comments
            case .failure(let error):
                print(error)
            }
        }
        
        XCTAssertNotEqual(catchComments?.count, 0)
    }
    
    
    func testGetFailureComment() {
        let comment = Comment(postID: 1,
                              id: 2,
                              name: "Foo",
                              email: "Baz",
                              body: "Bar")
        
        comments.append(comment)
        
        view = MockView()
        networkService = MockNetworkService()
        presenter = MainPresenter(view: view, networkService: networkService, router: router)
      
        var catchError:Error?
        
        networkService.getComments { (result) in
            switch result{
            case .success(_):
            break
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError)
    }
    
    
}
