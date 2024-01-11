//
//  ViewController.swift
//  ListView
//
//  Created by NigilDharsan on 13/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    var viewModel = ListViewModel()
    
    var dataModel = APICallRepository(apiClient: APIClient())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerCell()
        getlistData()
    }
    
    
    func registerCell() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
    }
//
}

//// MARK: - TableView Delegate..
extension ViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

//// MARK: - TableView DataSource..
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.listArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.loadCellData(details: self.viewModel.listArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - API Calling......

extension ViewController {
    
    func getlistData() {
        
        self.viewModel.getListAPI() { (Result) in
            
            if Result != nil {
                self.listTableView.reloadData()
            }else {
                print("Failer")
            }
        }
        
    }
}
    
