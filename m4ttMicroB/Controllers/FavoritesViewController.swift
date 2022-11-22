//
//  FavoritesViewController.swift
//  m4ttMicroB
//
//  Created by Mac on 18.11.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - Outlets:

    @IBOutlet weak var favoritesSearchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    
    
    //MARK: - Variebles data:
    
    
    
    
    //MARK: - ViewDidLoad:

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
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
