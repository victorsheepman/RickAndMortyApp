//
//  NetworkManagerTests.swift
//  RickAndMortyApp
//
//  Created by Victor Marquez on 23/7/24.
//

import XCTest
import Combine
@testable import RickAndMortyApp


struct MockResponse: Codable, Equatable {
    let userID, id: Int?
    let title, body: String?
}

final class NetworkManagerTests: XCTestCase {

    
       var cancellables: Set<AnyCancellable>!
       
       override func setUpWithError() throws {
           cancellables = []
           URLProtocol.registerClass(MockURLProtocol.self)
       }

       override func tearDownWithError() throws {
           cancellables = nil
           URLProtocol.unregisterClass(MockURLProtocol.self)
       }

       func testFetchDataSuccess() throws {
           // Define la URL y el modelo de prueba
           let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
           let mockResponse = MockResponse(
                userID: 1,
                id: 1,
                title: "qui est esse",
                body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
           )
           
           // Simula la respuesta
           MockURLProtocol.requestHandler = { request in
               let data = try! JSONEncoder().encode(mockResponse)
               let response = HTTPURLResponse(
                   url: request.url!,
                   statusCode: 200,
                   httpVersion: nil,
                   headerFields: nil
               )!
               return (response, data)
           }
           
           // Llama al método fetchData
           let expectation = self.expectation(description: "FetchData should succeed")
           
           NetworkManager.shared.fetchData(from: url, responseType: MockResponse.self)
               .sink(receiveCompletion: { completion in
                   if case .failure(let error) = completion {
                       XCTFail("Expected success, but got error: \(error)")
                   }
               }, receiveValue: { response in
                   XCTAssertEqual(response, mockResponse, "Expected \(mockResponse) but got \(response)")
                   expectation.fulfill()
               })
               .store(in: &cancellables)
           
           waitForExpectations(timeout: 5, handler: nil)
       }

}
