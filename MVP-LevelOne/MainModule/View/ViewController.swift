//
//  ViewController.swift
//  MVP-LevelOne
//
//  Created by Dima Khymych on 28.09.2020.
//

import UIKit
//MARK: - VIEW Layer
class ViewController: UIViewController {

    let indetifier = "Cell"

    @IBOutlet weak var tableView: UITableView!
    
    var presenter:MainViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: indetifier)
    }

 

}


extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: indetifier, for: indexPath)
       
        let comment = presenter.comments?[indexPath.row]
        
        cell.textLabel?.text = comment?.body
        
        return cell
    }
    
    
}


extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let comment = presenter.comments?[indexPath.row]
        presenter.tapOnTheComment(comment: comment)
        
    }
}


extension ViewController:MainViewProtocol {
    func failure(_ error: Error) {
        print(error)
    }
    
    func succes() {
        tableView.reloadData()
    }

    
}
