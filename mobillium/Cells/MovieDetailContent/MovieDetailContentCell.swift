//
//  MovieDetailContentCell.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class MovieDetailContentCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDetail: UITextView!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieDate: UILabel!

    @IBOutlet weak var imdbBtn: UIButton!
    @IBAction func imdbBtnClick(_ sender: Any) {

        DispatchQueue.main.async {

            guard let url = URL(string: "https://www.imdb.com/title/\(self.movie?.imdb_id ?? "")") else { return }
            UIApplication.shared.open(url)
        }

    }

    var movie:Details? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(movie:Details) {
        self.movie = movie

        var date = ""
        if movie.release_date != nil{
            date = "\(convertDateFormater(movie.release_date ?? "",format: "dd.MM.yyyy"))"
        }

        self.movieTitle.text = self.movie?.original_title
        self.movieDetail.text = self.movie?.overview
        self.movieRate.text = self.movie?.vote_average?.toString()
        self.movieDate.text = date



    }
    
}
