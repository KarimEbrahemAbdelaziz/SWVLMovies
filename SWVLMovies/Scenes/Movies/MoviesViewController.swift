//
//  MoviesViewController.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    var configurator = MoviesConfiguratorImplementation()
    var presenter: MoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(moviesViewController: self)
        presenter.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }
    
}

// MARK: - MoviesView

extension MoviesViewController: MoviesView {
    func refreshMoviesView() {
        
    }
    
    func displayMoviesRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
}
