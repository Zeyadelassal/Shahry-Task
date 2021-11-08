//
//  ProductDetailsViewController.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 08/11/2021.
//

import UIKit
import Cosmos
import Kingfisher

class ProductDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewRate: CosmosView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnBack: BackButton!

    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    var viewModel : ProductListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupParallaxEffect()
        setupRatingView()
        setupImage()
        setupLabels()
        setupBackButton()
    }
        
    private func setupRatingView(){
        viewRate.settings.updateOnTouch = false
        viewRate.settings.starSize = 28
        viewRate.settings.fillMode = .precise
        viewRate.settings.filledColor = .black
        viewRate.settings.emptyBorderColor = .black
        viewRate.settings.emptyBorderWidth = 1
        viewRate.settings.filledBorderColor = .black
        viewRate.rating = viewModel?.selectedProduct?.rating?.rate ?? 0.0
    }
    
    private func setupLabels(){
        
        let title = viewModel?.selectedProduct?.title ?? ""
        let price = "\(viewModel?.selectedProduct?.price ?? 0.0) \(CONSTANTS.CURRENCY)"
        let category = viewModel?.selectedProduct?.category ?? ""
        let desc = "Description:\n \(viewModel?.selectedProduct?.description ?? "")"
        let rating = "\(viewModel?.selectedProduct?.rating?.rate ?? 0.0)"
        let count = "\(viewModel?.selectedProduct?.rating?.count ?? 0) reviews"
        
        lblTitle.setupLabelWith(text:title, size: 18, weight: .bold)
        lblCategory.setupLabelWith(text: category, size: 14, weight: .regular)
        lblPrice.setupLabelWith(text:price , size: 18, weight: .bold)
        lblDesc.setupLabelWith(text: desc, size: 18, weight: .bold)
        lblRating.setupLabelWith(text: rating, size: 32, weight: .bold)
        lblCount.setupLabelWith(text: count, size: 12, weight: .regular)
    }
    
    private func setupImage(){
        let placeHolder = UIImage(named: IMAGES.PRODUCT_PLACE_HOLDER)
        if let imageURL = URL(string: viewModel?.selectedProduct?.image ?? "") {
            let resource = ImageResource(downloadURL: imageURL)
            imgProduct.kf.indicatorType = .activity
            imgProduct.kf.setImage(with: resource, placeholder: placeHolder)
        }else{
            imgProduct.image = placeHolder
        }
    }
    
    private func setupParallaxEffect(){
        imgProduct.contentMode = .scaleAspectFill
        imgProduct.clipsToBounds = true
        scrollView.contentInsetAdjustmentBehavior = .never
        stackViewTopConstraint.constant = UIScreen.main.bounds.height * (2/3)
    }
    
    private func setupBackButton(){
        btnBack.viewController = self
    }

}
