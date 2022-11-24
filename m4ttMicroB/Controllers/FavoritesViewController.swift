//
//  FavoritesViewController.swift
//  m4ttMicroB
//
//  Created by Mac on 18.11.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: -  Storage Data:
    
    let storage = Storage.shared

    
    //MARK: - Outlets:

    @IBOutlet weak var favoritesSearchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    
    //MARK: - Variebles data:
    
    
    
    
    //MARK: - ViewDidLoad:

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.register(UINib(nibName: "ShowTableViewCell",
                                          bundle: nil),
                                    forCellReuseIdentifier: "ShowTableViewCell")
        
    }
    
    //MARK: - ViewWillAppear:
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesTableView.reloadData()
        print("FavoritesViewController")
    }
    
    //MARK: - Setup for Navigation Bar:
    
    func setupNavigationBar() {
        UIApplication.shared.statusBarUIView?.backgroundColor = UIColor(named: "statusBarColor")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backgroundColor = UIColor(named: "statusBarColor")
        navigationController?.navigationBar.prefersLargeTitles = false
        favoritesSearchBar.barTintColor = UIColor(named: "navBarColor")
        favoritesSearchBar.searchTextField.backgroundColor = .white
    }
    

}

//MARK: - Extensions:

extension FavoritesViewController: UITableViewDelegate,
                                   UITableViewDataSource,
                                   UISearchBarDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.results.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowTableViewCell", for: indexPath) as! ShowTableViewCell
        let item = storage.results[indexPath.row]
        
        cell.likeOutlet.tag = indexPath.row
        cell.setupCellForFavorite(nameLabel: item.nameLabel,
                                  genresLabel: item.genresLabel,
                                  ratingLabel: item.ratingLabel)
        return cell
    }
    
}
