//
//  RouterTest.swift
//  MVP-LevelOneTests
//
//  Created by Dima Khymych on 01.10.2020.
//

import XCTest
@testable import MVP_LevelOne


class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: true)
    }
}

class RouterTest: XCTestCase {

    var router:RouterProtocol!
    var navContr = MockNavigationController()
    let assembly = AssemblyBuilder()
    
    
    override func setUpWithError() throws {
       
        router = Router(navigation: navContr, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        router = nil
    }

    
    func testRouter() {
        router.showDeteil(comment: nil)
        let detailVC = navContr.presentedVC
        XCTAssertTrue(detailVC is DetailViewController)
    }

}
