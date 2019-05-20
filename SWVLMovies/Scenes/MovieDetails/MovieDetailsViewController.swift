//
//  MovieDetailsViewController.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Foundation
import SkeletonView
import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieRateLabel: UILabel!
    
    // MARK: - Properties
    
    var configurator: MovieDetailsConfiguratorImplementation!
    var presenter: MovieDetailsPresenter!
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(movieDetailsViewController: self)
        presenter.viewDidLoad()
    }
    
    // MARK: - IBActions
    
    @IBAction private func backToMovies(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Functions
    
    private func setupMovieImageView() {
        movieImage.isSkeletonable = true
        
        movieImage.layer.cornerRadius = 16
        movieImage.clipsToBounds = true
        movieImage.layer.shadowColor = UIColor.lightGray.cgColor
        movieImage.layer.shadowOpacity = 0.5
        movieImage.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
    
    private func setupLabels() {
        movieTitleLabel.isSkeletonable = true
        movieRateLabel.isSkeletonable = true
    }
    
    private func setGradientBackground() {
        let colorBottom =  UIColor(red: 0.529, green: 0.737, blue: 0.914, alpha: 1.0).cgColor
        let colorTop = UIColor(red: 0.278, green: 0.341, blue: 0.624, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func showLoadingSkeleton() {
        let halfAlphaWhite = UIColor.white.withAlphaComponent(0.3)
        let halfAlphaBlue = UIColor.skyBlue.withAlphaComponent(0.3)
        let gradiant = SkeletonGradient(baseColor: halfAlphaBlue, secondaryColor: halfAlphaWhite)
        
        movieImage.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieTitleLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieRateLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
    }
    
    private func hideLoadingSkeleton() {
        movieImage.hideSkeleton()
    }
    
}

// MARK: - MovieDetailsView

extension MovieDetailsViewController: MovieDetailsView {
    func showLoadingState() {
        showLoadingSkeleton()
    }
    
    func hideLoadingState() {
        hideLoadingSkeleton()
    }
    
    func setupUI() {
        setGradientBackground()
        setupMovieImageView()
    }
}
