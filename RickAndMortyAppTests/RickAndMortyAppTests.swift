//
//  RickAndMortyAppTests.swift
//  RickAndMortyAppTests
//
//  Created by Victor Marquez on 23/7/24.
//

import XCTest
import Combine
@testable import RickAndMortyApp



final class RickAndMortyAppTests: XCTestCase {
    
     var cancellables: Set<AnyCancellable>!
     
     override func setUpWithError() throws {
         cancellables = []
         URLProtocol.registerClass(MockURLProtocol.self)
     }

     override func tearDownWithError() throws {
         cancellables = nil
         URLProtocol.unregisterClass(MockURLProtocol.self)
     }

}


class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("Received unexpected request with no handler set")
            return
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}
