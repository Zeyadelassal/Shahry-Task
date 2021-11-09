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
    let refreshControl = UIRefreshControl()
    var viewModel : ProductListViewModel?
    let disposeBag = DisposeBag()
    var retry = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        viewModel = ProductListViewModel()
        setupLabels()
        setupCollectionView()
        observeCollectionView()
        observeErrors()
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
    
    func observeErrors(){
        viewModel?.errorSubject.subscribe(onNext: {
            [weak self] error in
            guard let self = self else {return}
            self.stopActivityIndicator()
            self.showAlert(title: CONSTANTS.ALERT_TITLE_ERROR, message: error, actionTitle: CONSTANTS.ALERT_ACTION_RETRY) {
                if self.retry < 2{
                    self.viewModel?.getProducts()
                }
                self.retry += 1
            }
        }).disposed(by: disposeBag)
    }

}
