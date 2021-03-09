//
//  ConverterServiceTests.swift
//  CurrencyConverterTests
//
//  Created by Jan Bjelicic on 09/03/2021.
//

import XCTest
@testable import CurrencyConverter

class ConverterServiceTests: XCTestCase {
    
    private var sut: ConverterService!
    private var fakeNetworkManager: FakeNetworkManager!
    
    override func setUp() {
        super.setUp()
        self.fakeNetworkManager = FakeNetworkManager()
        self.sut = ConverterService(networkManager: fakeNetworkManager)
    }
    
    func test_given_convertCurrency_then_checkPathMethod() {
        let expectation = XCTestExpectation(description: #function)
        fakeNetworkManager.response = TestConverterResponseBuilder.getConverterResponse()
        let testRequest = ConvertRequest(from: Currency.euro.rawValue, to: Currency.britishPound.rawValue, amount: 4.0)
        sut.convert(testRequest).subscribe(onNext: { _ in
            expectation.fulfill()
        }, onError: { error in
            XCTFail("Test should not fail \(error)")
        }).dispose()
        wait(for: [expectation], timeout: 10)
        XCTAssertEqual(fakeNetworkManager.method, .get)
        XCTAssertEqual(fakeNetworkManager.path, "fx-rates")
    }
}
