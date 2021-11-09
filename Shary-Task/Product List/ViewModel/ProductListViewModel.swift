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
    
    let productsRelay : BehaviorRelay<[ProductView]> = BehaviorRelay(value: [])
    let productsDriver : Driver<[ProductView]>?
    let errorSubject : PublishSubject<String> = PublishSubject()
    
    var productsCount = 7
    var NextLimit = 7
    var isFetchingData = false
    
    var selectedProduct : ProductView?
    
    init(){
        productsDriver = productsRelay.asDriver(onErrorJustReturn: [])
    }
    
    var selectedProductIndex : Int = 0{
        didSet{
            self.selectedProduct = self.productsRelay.value[selectedProductIndex]
        }
    }
    
    
    func getProducts(){
        let parameters = createParametersToGetProducts()
        isFetchingData = true
        dataSource.getProducts(parameters: parameters, isSuccess: {
            [weak self] onlineProducts , offlineProducts in
            guard let self = self else {return}
            var products : [ProductView]?
            if let onlineProducts = onlineProducts {
                self.isFetchingData = false
                if onlineProducts.count == 7{
                    self.cacheProducts(products: onlineProducts)
                }
                self.productsCount = onlineProducts.count
                self.NextLimit += 7
                products = self.createOnlineProductsView(products: onlineProducts)
            }else{
                if let offlineProducts = offlineProducts , self.productsCount <= 7{
                    products = self.createOfflineProductsView(products: offlineProducts)
                    self.errorSubject.onNext(CONSTANTS.ERROR_CONNECTION)
                }
            }
            guard let products = products else{
                self.errorSubject.onNext(CONSTANTS.ERROR_GENERAL)
                return
            }
            self.productsRelay.accept(products)

        }, isError: {
            [weak self] error in
            guard let self = self else {return}
            self.isFetchingData = false
            guard let error = error else {
                self.errorSubject.onNext(CONSTANTS.ERROR_GENERAL)
                return
            }
            self.errorSubject.onNext(error)
        })
    }
    
    private func createParametersToGetProducts()->[String:Any]{
        let parameters = [WEB_SERVICE_KEY.LIMIT: NextLimit]
        return parameters
    }
    
    
    private func cacheProducts(products:[Product]){
        DataController.sharedInstance().deleteProducts()
        for product in products{
            let imageData = getImageData(imageURL:product.image ?? "")
            DataController.sharedInstance().saveProduct(product: product, imageData: imageData ?? Data())
        }
    }
    
    private func getImageData(imageURL:String)->Data?{
        guard let url = URL(string:imageURL) else {return nil}
        return try? Data(contentsOf: url)
    }
    
    private func createOnlineProductsView(products:[Product])->[ProductView]{
        return products.map { product in
            return ProductView(id: product.id, title: product.title, price: product.price, description: product.description, category: product.category, image: product.image, imageData: nil, rate: product.rating?.rate, count: product.rating?.count)
        }
    }
    
    private func createOfflineProductsView(products:[ProductEntity])->[ProductView]{
        return products.map { product in
            return ProductView(id: Int(product.id), title: product.title, price: product.price, description: product.desc, category: product.category, image: nil, imageData: product.image, rate: product.rating, count: Int(product.count))
        }
    }
}
