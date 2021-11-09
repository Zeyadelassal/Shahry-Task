//
//  ProductListDataSource.swift
//  Shary-Task
//
//  Created by ZeyadElassal on 07/11/2021.
//

import Foundation
import Alamofire
import CoreData

class ProductListDataSource{
    
    func getProducts(parameters:[String:Any],isSuccess:@escaping([Product]?,[ProductEntity]?)->Void,isError:@escaping(String?)->Void){
    
        if NetworkConnection.isConnectedToNetwork(){
            Network.sharedInstance().getMethod(
                url: WEB_SERVICE.PRODUCTS,
                parameters: parameters,
                headers: nil,
                encoding: URLEncoding.default,
                isSuccess: { (products : [Product]?) in
                    guard let products = products else {
                        isSuccess(nil,nil)
                        return
                    }
                    isSuccess(products,nil)
                },
                isError: {
                    error in
                    guard let error = error else {
                        isError(nil)
                        return
                    }
                    isError(error)
                }
            )
        }else{
            getOfflineProducts(isSuccess: { products in
                guard let products = products else {
                    isSuccess(nil,nil)
                    return
                }
                isSuccess(nil,products)
            }, isError: {
                error in
                isError(error)
            })
        }
    }
    
    
    
    private func getOfflineProducts(isSuccess:@escaping([ProductEntity]?)->Void,isError:@escaping(String?)->Void){
        
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        if let products = try? DataController.sharedInstance().viewContext.fetch(fetchRequest){
            isSuccess(products)
        }else{
            isError("Something went wrong.")
        }
    }
}
