//
//  ProductListViewController+CollectionView.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension ProductListViewController{
    
    func setupCollectionView(){
        colProducts.registerCell(ProductListCollectionViewCell.self)
        colProducts.backgroundColor = .clear
        colProducts.showsVerticalScrollIndicator = false
        colProducts.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func observeCollectionView(){
        viewModel?.productsDriver?.drive(colProducts.rx.items(cellIdentifier: ProductListCollectionViewCell.className, cellType: ProductListCollectionViewCell.self)){
            row,item,cell in
            let title = item.title ?? "No provided title"
            let category = item.category ?? "N/A"
            let rating = String(item.rating?.rate ?? 0.0)
            let count =  String(item.rating?.count ?? 0)
            let image = item.image ?? ""
            cell.setupCell(title: title, category: category, rating: rating, count: count, image: image)
        }.disposed(by: disposeBag)
        
        colProducts.rx.prefetchItems.subscribe(onNext:{
            [weak self] indexPaths in
            guard let self = self else {return}
            guard let viewModel = self.viewModel else {return}
            print(indexPaths.count)
            for indexPath in indexPaths{
                if indexPath.item >= viewModel.productsCount - 3 && !viewModel.isFetchingData{
                    viewModel.getProducts()
                    break
                }
            }
        }).disposed(by: disposeBag)
        
        colProducts.rx.itemSelected.subscribe(onNext: {
            [weak self] indexPath in
            guard let self = self else {return}
            guard let viewModel = self.viewModel else {return}
            viewModel.selectedProductIndex = indexPath.item
            self.moveToProductDetails()
        }).disposed(by: disposeBag)
    }
    
}

extension ProductListViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 60 - 10 ) / 2
        let height = (collectionView.frame.size.height - 20) / 2.5
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 30, bottom: 5, right: 30)
    }
}
