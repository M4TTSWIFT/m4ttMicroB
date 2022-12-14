//
//  MainViewController.swift
//  m4ttMicroB
//
//  Created by Mac on 18.11.2022.
//

import UIKit
import Alamofire
import Kingfisher

class MainViewController: UIViewController {
    
    //MARK: - Outlets:
    
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variebles and constants data:
    
    // Model:
    var showsData = [ShowsModel]()
    // SearchBar:
    let searchBarFilter = FavoriteSearch.shared
    // UINib:
    private let nib = UINib(nibName: "ShowTableViewCell", bundle: nil)
    // URL Session:
    private let dataURL = "https://api.tvmaze.com/schedule/full" // U can add or delete "/full" to more data
    private let noPicURL = URL(string: "https://static.tvmaze.com/images/no-img/no-img-portrait-text.png")
    
    
    //MARK: - ViewDidLoad:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupNavigationBar()
        activityIndicator.startAnimating()
        searchBarFilter.filteredShowsData = showsData
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBarFilter.filteredShowsData = []
        searchBarFilter.filteredShowsData = showsData
        
    }
    
    //MARK: - TableView setup:
    
    func setupTableView() {
        mainTableView.register(nib, forCellReuseIdentifier: "ShowTableViewCell")
        mainTableView.delegate         = self
        mainTableView.dataSource       = self
        mainSearchBar.delegate         = self
    }
    
    //MARK: - Setup for Navigation Bar:
    
    func setupNavigationBar() {
        UIApplication.shared.statusBarUIView?.backgroundColor = UIColor(named: "statusBarColor")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = UIColor(named: "statusBarColor")
        navigationController?.navigationBar.prefersLargeTitles = false
        mainSearchBar.barTintColor = UIColor(named: "navBarColor")
        mainSearchBar.searchTextField.backgroundColor = .white
        
    }
    
    //MARK: - FetchData from the API:
    
    func fetchData() {
        AF.request(dataURL)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [ShowsModel].self) {
                response in
                switch response.result {
                case .success(let shows):
                    self.showsData = shows
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.searchBarFilter.filteredShowsData = self.showsData
                    
                case .failure(let error):
                    print("error", error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            }
    }
    
}

//MARK: - Extensions

extension MainViewController: UITableViewDelegate,
                              UITableViewDataSource,
                              UISearchBarDelegate {
    
    //MARK: - TableView extensions are here:
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchBarFilter.filteredShowsData.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTableViewCell", for: indexPath) as! ShowTableViewCell
        let show = searchBarFilter.filteredShowsData[indexPath.row]
        let noRating = 0.0
        // showImageCircularView:
        cell.showImage.layer.masksToBounds = false
        cell.showImage.layer.cornerRadius = cell.showImage.frame.size.width / 2
        cell.showImage.clipsToBounds = true
        // showImageNilCheck:
        if show._embedded.show.image != nil {
            if show._embedded.show.image?.medium != nil {
                cell.showImage.kf.setImage(with: URL(string: "\(show._embedded.show.image!.medium!)"))
            }
        } else {
            cell.showImage.kf.setImage(with: noPicURL)
        }
        //-----------------------
        cell.likeOutlet.tag = show._embedded.show.id
        //-----------------------
        cell.setupCells(nameLabel: show._embedded.show.name,
                        genresLabel: "\(show._embedded.show.genres.joined(separator: ", "))", ratingLabel: "Rating: \(show._embedded.show.rating?.average ?? noRating)",
                        id: show._embedded.show.id,
                        indexPath: indexPath)
        return cell
    }
    
    //MARK: - SearchBar extensions are here:
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarFilter.filteredShowsData = []
        
        
        if searchText == "" {
            searchBarFilter.filteredShowsData = showsData
        } else {
            for show in showsData {
                if show._embedded.show.name.lowercased().contains(searchText.lowercased()) {
                    searchBarFilter.filteredShowsData.append(show)
                }
            }
        }
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}


