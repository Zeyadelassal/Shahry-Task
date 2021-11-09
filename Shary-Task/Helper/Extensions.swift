//
//  Extensions.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import UIKit

fileprivate var indicatorView:UIView?

extension NSObject {
    
    static public var className: String {
        return String(describing: self)
    }
    
    static public var nibName : UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.nibName, forCellWithReuseIdentifier: T.className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.className,for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return cell
    }
    
}


extension UILabel{
    
    func setupLabelWith(text : String,size:CGFloat, weight:UIFont.Weight, color : UIColor = .black){
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.text = text
        self.textColor = color
    }

}

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    static var gold : UIColor { UIColor(hex: 0xfdbc4b)}
    static var grey : UIColor { UIColor(hex: 0xBEBCBB)}
    static var mainGreen : UIColor { UIColor(hex:0x25B56E)}

}


extension UIView{
    func createShadow(color:UIColor,opacity:Float,offset:CGSize,radius:CGFloat,cornerRadius:CGFloat){
        layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
}

extension UIViewController{
    
    func showActivityIndicator() {
        view.alpha = 0.5
        indicatorView = UIView(frame: UIScreen.main.bounds)
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.center = (indicatorView?.center)!
        indicator.color = .mainGreen
        //UIColor(rgb: 0x1d3557)
        indicator.startAnimating()
        indicatorView?.addSubview(indicator)
        self.view.addSubview(indicatorView!)
    }
    
    func stopActivityIndicator(){
        UIView.animate(withDuration:2) {
            [weak self] in
            guard let self = self else {return}
            self.view.alpha = 1
        }
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
    
    func showAlert(title:String,message:String,actionTitle:String,completion:@escaping()->Void){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: actionTitle, style: UIAlertAction.Style.cancel){(action) in
            completion()
            alert.dismiss(animated: true, completion: nil)}
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}
