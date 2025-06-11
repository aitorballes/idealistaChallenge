import Foundation

final class MockNetworkInteractor: URLProtocol {
    
    var urlAdvertisementsList: URL {
        Bundle.main.url(forResource: "advertisement_list", withExtension: "json")!
    }
    
    var urlAdvertisementDetail: URL {
        Bundle.main.url(forResource: "advertisement_detail", withExtension: "json")!
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        defer {
            client?.urlProtocolDidFinishLoading(self)
        }
        
        guard let url = request.url else { return }
        
        if url.lastPathComponent == "list.json" {
            guard let data = try? Data(contentsOf: urlAdvertisementsList)
            else { return }

            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(
                self,
                didReceive: getSuccessResponseForUrl(url: url),
                cacheStoragePolicy: .notAllowed
            )
        }
        
        if url.lastPathComponent == "detail_1.json" {
            guard let data = try? Data(contentsOf: urlAdvertisementDetail)
            else { return }

            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(
                self,
                didReceive: getSuccessResponseForUrl(url: url),
                cacheStoragePolicy: .notAllowed
            )
        }        
    }
    
    override func stopLoading() {
        // No additional cleanup needed for mock
    }
    
    private func getSuccessResponseForUrl(url: URL) -> HTTPURLResponse {
        return HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: [
                "Content-Type": "application/json;chatset=utf-8"
            ]
        )!
    }
    
}
