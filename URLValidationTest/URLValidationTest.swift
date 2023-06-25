//
//  URLValidationTest.swift
//  URLValidationTest
//
//  Created by Ricky Zheng on 6/25/23.
//

import XCTest

final class URLValidationTest: XCTestCase {
    // Test Dessert List API URL
    func testListURL() async throws {
        let listURL = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        
        let listDataAndResponse: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: listURL,
                                                                                                    delegate: nil)
        let listHttpResponse = try XCTUnwrap(listDataAndResponse.response as? HTTPURLResponse, "Expected an HTTPURLResponse.")
        
        // Test for OK HTTP Status Code
        XCTAssertEqual(listHttpResponse.statusCode, 200, "Expected a 200 OK response")
        
        // Test for decoding JSON response
        XCTAssertNoThrow(try JSONDecoder().decode(Meals.self, from: listDataAndResponse.data))
    }
    
    func testDetailURL() async throws {
        let detailsURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID")!
        
        let detailsDataAndResponse: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: detailsURL,
                                                                                                           delegate: nil)
        let detailsHttpResponse = try XCTUnwrap(detailsDataAndResponse.response as? HTTPURLResponse, "Expected an HTTPURLResponse.")
        
        // Test for OK HTTP Status Code
        XCTAssertEqual(detailsHttpResponse.statusCode, 200, "Expected a 200 OK response")
        
        // Test for decoding JSON response
        XCTAssertThrowsError(try JSONDecoder().decode(Meals.self, from: detailsDataAndResponse.data))
    }
    
    func testValidDetailURL() async throws {
        let validDetailsURL = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=52893")!
        
        let validDetailsDataAndResponse: (data: Data, response: URLResponse) = try await URLSession.shared.data(from: validDetailsURL, delegate: nil)
        let validDetailsHttpResponse = try XCTUnwrap(validDetailsDataAndResponse.response as? HTTPURLResponse, "Expected an HTTPURLResponse.")
        
        // Test for OK HTTP Status Code
        XCTAssertEqual(validDetailsHttpResponse.statusCode, 200, "Expected a 200 OK response")
        
        // Test for decoding JSON response
        XCTAssertNoThrow(try JSONDecoder().decode(Meals.self, from: validDetailsDataAndResponse.data))
    }
}
