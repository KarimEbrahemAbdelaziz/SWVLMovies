//
//  MovieCell.swift
//  SWVLMovies
//
//  Created by Karim Ebrahem on 5/19/19.
//  Copyright © 2019 Karim Ebrahem. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 16
    }
    
}

// MARK: - MovieCellView

extension MovieCell: MovieCellView {
    func configure(with viewModel: MovieCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.yearLabel.text = viewModel.year
        self.rateLabel.text = viewModel.rate
    }
}
