//
//  MovieDetailBigImage.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit

class MovieDetailBigImage: UITableViewCell {

    @IBOutlet weak var MovieBigImage: UIImageView!
    @IBOutlet weak var backBtn: UIView!

    var vc:UIViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        generateClick(target: self, selector: #selector(backBtnFnc), view: backBtn)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(vc:UIViewController,url:String) {
        self.vc = vc
        print(url)
        MovieBigImage.setImageKF(url: url)
        
    }

    @objc func backBtnFnc(){

        vc.self?.dismiss(animated: true, completion: nil)
    }
    
}
