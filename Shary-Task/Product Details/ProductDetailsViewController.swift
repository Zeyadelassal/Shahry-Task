//
//  ProductDetailsViewController.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 08/11/2021.
//

import UIKit

class ProductDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProduct.contentMode = .scaleAspectFill
        imgProduct.clipsToBounds = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(imgProduct.frame.height)
    }
    
}
