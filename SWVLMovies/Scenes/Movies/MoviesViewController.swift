//
//  MoviesViewController.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var moviesTableView: UITableView!
    
    // MARK: - Properties
    
    var configurator = MoviesConfiguratorImplementation()
    var presenter: MoviesPresenter!
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(moviesViewController: self)
        configureTableView()
        
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Private Functions
    
    private func configureTableView() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
    
}

// MARK: - UITableViewDataSource

extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }
}

// MARK: - MoviesView

extension MoviesViewController: MoviesView {
    func refreshMoviesView() {
        moviesTableView.reloadData()
    }
    
    func displayMoviesRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
}
