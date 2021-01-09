//
//  MainTableViewController.swift
//  MovieInfoApp
//
//  Created by Ibragim Akaev on 09/01/2021.
//

import UIKit
import SafariServices

class MainTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    //MARK: - Public properties
    let searchController = UISearchController(searchResultsController: nil)
    private var activityIV: UIActivityIndicatorView!
    
    //MARK: - Private properties
    private var networkManager = NetworkManager()
    private var timer: Timer?
    private var text = "Batman"
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        
        setupNavbarProperties()
        setupResults()
    }
    
    //MARK: - UITableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    //MARK: - Private Functions
    private func setupNavbarProperties() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func setupResults() {
        networkManager.fetchMovie(searchText: text) { [weak self] (searchResults) in
            let newMovies = searchResults?.search
            self?.movies.append(contentsOf: newMovies ?? [])
            self?.tableView.reloadData()
        }
    }
}

extension MainTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count >= 3 {
            text = searchText.replacingOccurrences(of: " ", with: "%20")
        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { (_) in
            
            self.networkManager.fetchMovie(searchText: self.text) { [weak self] (searchResults) in
                self?.movies.removeAll()
                let newMovies = searchResults?.search
                self?.movies.append(contentsOf: newMovies ?? [])
                self?.tableView.reloadData()
            }
        })
    }
}
