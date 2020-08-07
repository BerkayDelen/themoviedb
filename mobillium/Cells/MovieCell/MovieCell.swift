//
//  MovieCell.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieShortDetail: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieDetail: UIView!

    var movie:Results? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    func setData(url:String,title:String,Detail:String,Date:String) {

        self.movieImage.setImageKF(url: url)
    }
    func setData(movie:Results) {

        self.movieImage.setImageKF(url: "\(Constants.Api.imageUrl)\(movie.poster_path ?? "")")
        self.movieTitle.text = movie.original_title
        self.movieDate.text = movie.release_date
        self.movieShortDetail.text = movie.overview

    }
    
}
