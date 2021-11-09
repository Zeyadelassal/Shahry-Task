//
//  ProductListDataSourceTest.swift
//  Shary-TaskTests
//
//  Created by ZeyadElassal on 09/11/2021.
//

import XCTest
@testable import Shary_Task

class ProductListDataSourceTest : XCTestCase {
    
    var dataSource : ProductListDataSource!
    
    override func setUp(){
        dataSource = ProductListDataSource()
    }
    
    func testGetProducts(){
        let expectationObj = expectation(description: "Waiting For response...")
        let parameters = [WEB_SERVICE_KEY.LIMIT : 7]
        dataSource.getProducts(
            parameters: parameters,
            isSuccess:{ onlineProducts,offlineProducts in
                expectationObj.fulfill()
                XCTAssertNotNil(onlineProducts)
                for onlineProduct in onlineProducts!{
                    XCTAssertNotNil(onlineProduct.id)
                    XCTAssertNotNil(onlineProduct.title)
                    XCTAssertNotNil(onlineProduct.price)
                    XCTAssertNotNil(onlineProduct.description)
                    XCTAssertNotNil(onlineProduct.image)
                    XCTAssertNotNil(onlineProduct.category)
                    XCTAssertNotNil(onlineProduct.rating)
                    XCTAssertNotNil(onlineProduct.rating?.rate)
                    XCTAssertNotNil(onlineProduct.rating?.count)
                }
            }
            ,isError: {
                error in
                XCTAssertNotNil(error)
            })
        waitForExpectations(timeout: 15)
    }
    
    func testGetProductsWithBiggerLimit(){
        let expectationObj = expectation(description: "Waiting For response...")
        let parameters = ["limt" : 14]
        dataSource.getProducts(
            parameters: parameters,
            isSuccess:{ onlineProducts,offlineProducts in
                expectationObj.fulfill()
                XCTAssertNotNil(onlineProducts)
                XCTAssertNil(offlineProducts)
                XCTAssertEqual(onlineProducts!.count, 14)
            }
            ,isError: {
                error in
                XCTAssertNotNil(error)
            })
        waitForExpectations(timeout: 15)
    }
    
    override func tearDown() {
        dataSource = nil
    }
}


