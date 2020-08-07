//
//  Extension.swift
//  mobillium
//
//  Created by Berkay Delen on 6.08.2020.
//

import UIKit
import Foundation


extension UIImageView{
    func setImageKF(url:String){

        self.kf.setImage(with: URL(string: (url)),placeholder: UIImage(named: "MovieNotFound"))
    }
    func tint(color:UIColor){

        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}


extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}


extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
                                                            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
    func applyGradient(type:GradientType,colours: [UIColor]) -> Void {
        DispatchQueue.main.async {

            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
            if type == .topToBottom{
                gradient.startPoint = CGPoint(x : 0.0, y : 0)
                gradient.endPoint = CGPoint(x :0.0, y: 1)
            }else if type == .bottomToTop{
                gradient.startPoint = CGPoint(x : 0.0, y : 1)
                gradient.endPoint = CGPoint(x :0.0, y: 0)
            }

            self.layer.insertSublayer(gradient, at: 0)
        }
    }
    func applyGradientTopBottom(colours: [UIColor]) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x : 0.0, y : 0)
        gradient.endPoint = CGPoint(x :1.0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
}



extension UIView {
    @IBInspectable
    var circle: Bool {
        get {
            return layer.cornerRadius == min(self.frame.width, self.frame.height) / CGFloat(2.0) ? true : false
        }
        set {
            if newValue {
                layer.cornerRadius = layer.frame.size.width/2
                layer.masksToBounds = true
            }


        }
    }
    @IBInspectable
    var cornerCircle: Bool {
        get {
            return layer.cornerRadius == min(self.frame.width, self.frame.height) / CGFloat(2.0) ? true : false
        }
        set {
            if newValue {
                layer.cornerRadius = layer.frame.size.height/2
                layer.masksToBounds = true
            }


        }
    }
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    func placeHolderColorFunc(_ color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
