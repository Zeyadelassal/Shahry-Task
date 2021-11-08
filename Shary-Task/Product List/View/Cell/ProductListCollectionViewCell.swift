//
//  ProductListCollectionViewCell.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import UIKit
import Kingfisher

class ProductListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.numberOfLines = 2
        
    }
    
    
    func setupCell(title:String,category:String,rating:String,count:String,image:String){
        lblTitle.setupLabelWith(text: title, size: 14, weight: .semibold)
        lblCategory.setupLabelWith(text: category, size: 14, weight: .regular)
        lblRating.setupLabelWith(text: rating, size: 14, weight: .bold,color: .gold)
        lblCount.setupLabelWith(text: "(\(count))", size: 14, weight: .regular,color: .grey)
        setImage(image: image)
        setShadow()
    }
    
    private func setImage(image:String){
        let placeHolder = UIImage(named: IMAGES.PRODUCT_PLACE_HOLDER)
        if let imageURL = URL(string: image) {
            let resource = ImageResource(downloadURL: imageURL)
            imgProduct.kf.indicatorType = .activity
            imgProduct.kf.setImage(with: resource, placeholder: placeHolder)
        }else{
            imgProduct.image = placeHolder
        }
    }
    
    private func setShadow(){
        self.layer.cornerRadius = 14
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
    }
    
}
