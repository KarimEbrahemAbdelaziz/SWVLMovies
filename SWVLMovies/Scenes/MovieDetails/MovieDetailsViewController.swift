//
//  MovieDetailsViewController.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var configurator: MovieDetailsConfiguratorImplementation!
    var presenter: MovieDetailsPresenter!
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientBackground()
    }
    
    // MARK: - IBActions
    
    @IBAction private func backToMovies(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Functions
    
    private func setGradientBackground() {
        let colorBottom =  UIColor(red: 0.529, green: 0.737, blue: 0.914, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 0.278, green: 0.341, blue: 0.624, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

// MARK: - MovieDetailsView

extension MovieDetailsViewController: MovieDetailsView {
    
}
