//
//  CalcSwitUITests.swift
//  CalcSwitUITests
//
//  Created by subhayan.mukhopadhay on 05/02/23.
//

import XCTest
@testable import CalcSwitUI

class CalcSwitUITests: XCTestCase {
    let sut = ContentView()
    
    func testFormatResult(){
        
        
        let actual = sut.formatResult(val: 0.6666666666666666)
        let expected = "0.67"
        
        XCTAssertEqual(actual, expected)
    }

}
