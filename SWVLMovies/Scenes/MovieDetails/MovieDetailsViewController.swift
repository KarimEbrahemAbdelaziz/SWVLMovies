//
//  MovieDetailsViewController.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Cosmos
import Foundation
import SkeletonView
import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieRateCosmosView: CosmosView!
    
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
        movieYearLabel.isSkeletonable = true
    }
    
    private func setupRatingCosmosView() {
        movieRateCosmosView.isSkeletonable = true
        movieRateCosmosView.isUserInteractionEnabled = false
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
        movieYearLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieRateCosmosView.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
    }
    
    private func hideLoadingSkeleton() {
        movieImage.hideSkeleton()
        movieTitleLabel.hideSkeleton()
        movieYearLabel.hideSkeleton()
        movieRateCosmosView.hideSkeleton()
    }
    
    private func setupMovieDetails() {
        movieTitleLabel.text = presenter.movieTitle
        movieYearLabel.text = presenter.movieYear
        movieRateCosmosView.rating = presenter.movieRate
        movieImage.kf.setImage(with: presenter.movieImagesUrls.first!)
    }
    
}

// MARK: - MovieDetailsView

extension MovieDetailsViewController: MovieDetailsView {
    func refreshMoviesView() {
        
    }
    
    func showLoadingState() {
        showLoadingSkeleton()
    }
    
    func hideLoadingState() {
        hideLoadingSkeleton()
        setupMovieDetails()
    }
    
    func setupUI() {
        setGradientBackground()
        setupMovieImageView()
        setupRatingCosmosView()
        setupLabels()
    }
    
    func displayMovieRetrievalError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
}
