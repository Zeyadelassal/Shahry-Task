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
    @IBOutlet weak var lblPrice: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.numberOfLines = 2
    }
    
    
    func setupCell(title:String,category:String,rating:String,count:String,price:String){
        lblTitle.setupLabelWith(text: title, size: 14, weight: .semibold)
        lblCategory.setupLabelWith(text: category, size: 14, weight: .regular)
        lblRating.setupLabelWith(text: rating, size: 14, weight: .bold,color: .gold)
        lblCount.setupLabelWith(text: "(\(count))", size: 14, weight: .regular,color: .grey)
        lblPrice.setupLabelWith(text: price + " \(CONSTANTS.CURRENCY)", size: 14, weight: .bold,color: .mainGreen)
        setShadow()
    }
    
    func setupImageWith(image:String){
        setImage(image: image)
    }
    
    func setupImageWith(image:Data){
        imgProduct.image = UIImage(data: image)
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
        let shadowColor =  UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        createShadow(color: shadowColor, opacity: 1, offset: CGSize(width: 0, height: 0), radius: 8, cornerRadius: 14)
    }
    
}
