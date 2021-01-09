//
//  MovieTableViewCell.swift
//  Movie Searcher
//
//  Created by Ibragim Akaev on 09/01/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "MovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell",
                     bundle: nil)
    }
    
    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.title
        self.movieYearLabel.text = model.year
        let url = model.poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.moviePosterImageView.image = UIImage(data: data)
        }
    }
    
}
