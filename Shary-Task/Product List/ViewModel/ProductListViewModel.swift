//
//  ProductListViewModel.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ProductListViewModel{
    
    let dataSource = ProductListDataSource()
    let productsRelay : BehaviorRelay<[Product]> = BehaviorRelay(value: [])
    let productsDriver : Driver<[Product]>?
    let areProductsFetchedSuccessfully : PublishSubject<Bool> = PublishSubject()
    let errorSubject : PublishSubject<String> = PublishSubject()
    
    var productsCount = 7
    var NextLimit = 7
    var isFetchingData = false
    
    init(){
        productsDriver = productsRelay.asDriver(onErrorJustReturn: [])
    }
    
    
    func getProducts(){
        let parameters = createParametersToGetProducts()
        isFetchingData = true
        dataSource.getProducts(parameters: parameters, isSuccess: {
            [weak self] products in
            guard let self = self else {return}
            self.isFetchingData = false
            guard let products = products else {
                self.errorSubject.onNext("Something went wrong")
                return
            }
            self.productsCount = products.count
            self.NextLimit += 3
            self.productsRelay.accept(products)
        }, isError: {
            [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.errorSubject.onNext("Something went wrong")
                return
            }
            self.errorSubject.onNext(error)
        })
    }
    
    private func createParametersToGetProducts()->[String:Any]{
        let parameters = [WEB_SERVICE_KEY.LIMIT: NextLimit]
        return parameters
    }
}
