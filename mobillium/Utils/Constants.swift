//
//  Constants.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit
import Foundation



class Constants {
    struct Colors{
        
        static var gray = UIColor(hexString: "#808285")
        static var darkGray = UIColor(hexString: "#6D6E71")
        static var softGray = UIColor(hexString: "#939598")
        static var black = UIColor(hexString: "#000000")
        static var black50 = UIColor(hexString: "#000000",alpha: 0.5)
        static var red = UIColor(hexString: "#E20338")
        static var green = UIColor(hexString: "#5BFF62")
        
        static var transparent = UIColor(hexString: "#939598",alpha: 0)
        
        
    }
    struct Api {
        static let baseURL = "https://api.themoviedb.org/3/"
        
        static let imageUrl = "https://image.tmdb.org/t/p/w500"
        
        static let upcoming = "movie/upcoming"
        static let nowplaying = "movie/now_playing"
        static let search = "search/movie"
        static let detail = "movie/"
        static let similar = "similar"
        
        
        static let key = "1fc518ed42a18bb7b324590e97fd7b44"
        static let keyParam = "?api_key="
        static let keyUrl = "\(keyParam)\(key)"
        
    }
}
