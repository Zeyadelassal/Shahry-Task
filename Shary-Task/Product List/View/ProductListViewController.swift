//
//  ProductListViewController.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var colProducts: UICollectionView!
    
    //MARK:- PROPERTIES
    var viewModel : ProductListViewModel?
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductListViewModel()
        setupLabels()
        setupCollectionView()
        observeCollectionView()
        viewModel?.getProducts()
    }
    
    private func setupLabels(){
        lblHeader.setupLabelWith(text: "Hey👋", size: 14, weight: .bold)
        lblUserName.setupLabelWith(text: "Shary", size: 16, weight: .bold)
    }
    
    func moveToProductDetails(){
        let viewController = ProductDetailsViewController()
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }

}
