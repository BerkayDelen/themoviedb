//
//  HomeSliderCollectionViewCell.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class HomeSliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var sliderImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!

    var movie:Results? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code


        DispatchQueue.main.async {
            self.gradientView.applyGradient(type: .topToBottom,colours: [Constants.Colors.transparent,Constants.Colors.black50])
        }



    }

    func setData(movie:Results) {

        self.movie = movie

        var date = ""
        if movie.release_date != nil{
            date = " (\(convertDateFormater(movie.release_date ?? "",format: "yyyy")))"
        }
        sliderImage.setImageKF(url: "\(Constants.Api.imageUrl)\(movie.backdrop_path ?? "")")
        movieName.text = "\(movie.original_title!)\(date)"
    }

}
