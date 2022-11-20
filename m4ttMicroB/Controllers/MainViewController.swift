//
//  MainViewController.swift
//  m4ttMicroB
//
//  Created by Mac on 18.11.2022.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    //MARK: - Outlets:
    
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variebles and constants data:
    
    var showsDataModel = [ShowsModel]()
    
    // URL Session:
    
    // to many items are here: "https://api.tvmaze.com/schedule/full"
    let dataURL = "https://api.tvmaze.com/schedule/full"
    
    
    //MARK: - ViewDidLoad:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.register(UINib(nibName: "ShowTableViewCell",
                                          bundle: nil),
                                    forCellReuseIdentifier: "ShowTableViewCell")
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        fetchData()
        activityIndicator.startAnimating()
        
        //        mainSearchBar.delegate      = self
        
    }
    
    //MARK: - Setup for Navigation Bar:
    
    
    
    //MARK: - Setup for Search Bar:
    
    //MARK: - FetchData from the API:
    
    func fetchData() {
        AF.request(dataURL)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [ShowsModel].self) {
                response in
                switch response.result {
                case .success(let shows):
                    print("on my way:", shows)
                    self.showsDataModel = shows
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    print("=====\(self.showsDataModel.count)=======")
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(">>>> \(showsDataModel.count ) <<<<")
        return showsDataModel.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTableViewCell", for: indexPath) as! ShowTableViewCell
        let show = showsDataModel[indexPath.row]
        let noRating = 0.0
        cell.nameLabel?.text = "\(show.name)"
        cell.detailLabel?.text = "Episode: \(show.number ?? 0) \nDuration: \(show.runtime ?? 0) min"
        cell.ratingLabel?.text = "Rating: \(show.rating?.average ?? noRating)"
        return cell
    }
    
}
