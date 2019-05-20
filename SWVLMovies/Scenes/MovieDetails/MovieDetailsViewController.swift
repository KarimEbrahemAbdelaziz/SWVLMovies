//
//  MovieDetailsViewController.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/20/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import Cosmos
import Foundation
import Kingfisher
import SkeletonView
import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieCastLabel: UILabel!
    @IBOutlet private weak var movieGenresLabel: UILabel!
    @IBOutlet private weak var movieRateCosmosView: CosmosView!
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    
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
        movieCastLabel.isSkeletonable = true
        movieGenresLabel.isSkeletonable = true
    }
    
    private func setupRatingCosmosView() {
        movieRateCosmosView.isSkeletonable = true
        movieRateCosmosView.isUserInteractionEnabled = false
    }
    
    private func setGradientBackground() {
        let bottomColor =  UIColor.skyBlue.cgColor
        let topColor = UIColor.semiBlue.cgColor
        
        self.setGradientBackground(topColor: topColor, bottomColor: bottomColor)
    }
    
    private func showLoadingSkeleton() {
        let halfAlphaWhite = UIColor.white.withAlphaComponent(0.3)
        let halfAlphaBlue = UIColor.skyBlue.withAlphaComponent(0.3)
        let gradiant = SkeletonGradient(baseColor: halfAlphaBlue, secondaryColor: halfAlphaWhite)
        
        movieImage.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieTitleLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieYearLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieRateCosmosView.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieCastLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
        movieGenresLabel.showAnimatedGradientSkeleton(usingGradient: gradiant, animation: nil)
    }
    
    private func hideLoadingSkeleton() {
        movieImage.hideSkeleton()
        movieTitleLabel.hideSkeleton()
        movieYearLabel.hideSkeleton()
        movieRateCosmosView.hideSkeleton()
        movieCastLabel.hideSkeleton()
        movieGenresLabel.hideSkeleton()
    }
    
    private func setupMovieDetails() {
        movieTitleLabel.text = presenter.movieTitle
        movieYearLabel.text = presenter.movieYear
        movieRateCosmosView.rating = presenter.movieRate
        movieImage.image = UIImage(named: "swvl")
        movieCastLabel.text = presenter.movieCast
        movieGenresLabel.text = presenter.movieGenres
    }
    
}

// MARK: - UICollectionViewDataSource

extension MovieDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.movieImagesUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.configureCell(with: presenter.movieImagesUrls[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (imagesCollectionView.frame.size.width - 10) / 2.0
        return CGSize(width: size, height: size)
    }
}

// MARK: - MovieDetailsView

extension MovieDetailsViewController: MovieDetailsView {
    func refreshMoviesView() {
        imagesCollectionView.reloadData()
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
