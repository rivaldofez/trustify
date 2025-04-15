//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 15/04/25.
//

import Foundation

struct NetworkDebugger: Logging {

    func logRequest(request: URLRequest) {
        print("--- API Request ---")
        print("URL: \(request.url?.absoluteString ?? "N/A")")
        print("Method: \(request.httpMethod ?? "N/A")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers:")
            for (key, value) in headers {
                print("\t\(key): \(value)")
            }
        }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body:")
            print(bodyString)
        }
        print("-------------------")
    }

    func logResponse(response: URLResponse?, data: Data?) {
        guard let httpResponse = response as? HTTPURLResponse else {
            print("--- API Response ---")
            print("Invalid or no response received.")
            print("--------------------")
            return
        }

        print("--- API Response ---")
        print("Status Code: \(httpResponse.statusCode)")
        if let headers = httpResponse.allHeaderFields as? [String: String] {
            print("Headers:")
            for (key, value) in headers {
                print("\t\(key): \(value)")
            }
        }
        if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
            print("Response Body:")
            print(responseString)
        }
        print("--------------------")
    }
}
