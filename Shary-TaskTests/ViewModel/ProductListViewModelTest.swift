//
//  ProductListViewModelTest.swift
//  Shary-TaskTests
//
//  Created by ZeyadElassal on 09/11/2021.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Shary_Task

class ProductListViewModelTest: XCTestCase {

    var viewModel : ProductListViewModel!
    let disposeBag = DisposeBag()
    var expectationObj : XCTestExpectation!
    
    override func setUp(){
        viewModel = ProductListViewModel()
        viewModel.productsRelay.subscribe(
            onNext: {products in
                self.expectationObj.fulfill()
                XCTAssertNotNil(products)
                XCTAssertEqual(products.count, 7)
                for product in products{
                    XCTAssertNotNil(product.id)
                    XCTAssertNotNil(product.title)
                    XCTAssertNotNil(product.price)
                    XCTAssertNotNil(product.description)
                    XCTAssertNotNil(product.image)
                    XCTAssertNotNil(product.category)
                    XCTAssertNotNil(product.rate)
                    XCTAssertNotNil(product.count)
                    XCTAssertNil(product.imageData)
                }
            }).disposed(by: disposeBag)
    }

    
    func testGetProducts(){
        expectationObj = expectation(description: "Waiting For response...")
        viewModel.getProducts()
        waitForExpectations(timeout: 15)
    }
    
    
}
