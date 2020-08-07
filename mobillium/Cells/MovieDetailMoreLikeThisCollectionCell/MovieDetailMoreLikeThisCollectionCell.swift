//
//  MovieDetailMoreLikeThisCollectionCell.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class MovieDetailMoreLikeThisCollectionCell: UICollectionViewCell {



    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!


    var movie:Results? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(url:String,name:String,year:String) {

        self.movieImage.setImageKF(url: url)
        self.movieName.text = name
        self.movieYear.text = year

    }

    func setData(movie:Results) {
        self.movie = movie

        var date = ""
        if movie.release_date != nil{
            date = "(\(convertDateFormater(self.movie?.release_date ?? "",format: "yyyy")))"
        }

        self.movieImage.setImageKF(url: "\(Constants.Api.imageUrl)\(self.movie?.poster_path ?? "")")
        self.movieName.text = self.movie?.original_title
        self.movieYear.text = date
    }

}
