////
////  API.swift
////
////  Created by AppleBetas on 2017-01-15.
////  Copyright © 2017 AppleBetas. All rights reserved.
////
//
//import Foundation
//
//internal class GiphyAPI {
//    
//    static let shared = GiphyAPI(baseURL: URL(string: "https://www.24vetsupport.com/api/")!)
//    var baseURL: URL
//    
//    
//    /// Headers to add to every request, on top of any passed in the function parameters.
//    var globalHeaders = [String: String]()
//    
//    /// Create an API object with the specified API base URL.
//    init(baseURL: URL) {
//        self.baseURL = baseURL
//    }
//    
//    enum HTTPBody {
//        case text(String), data(Data), parameters([String: Any], ParameterEncoding)
//        
//        /// The data to send after processing this HTTP body.
//        var data: Data? {
//            switch self {
//            case .text(let body):
//                return body.data(using: .utf8)
//            case .data(let body):
//                return body
//            case .parameters(let dict, let encoding):
//                return encoding.encode(body: dict)
//            }
//        }
//        
//        /// Optionally, the content type to send with the body.
//        var contentType: String? {
//            switch self {
//            case .parameters(_, let encoding):
//                return encoding.contentType
//            case .text(_):
//                return "text/plain; charset=utf-8"
//            default:
//                return nil
//            }
//        }
//    }
//    
//    enum HTTPMethod {
//        case GET
//        case POST(HTTPBody), PUT(HTTPBody), PATCH(HTTPBody)
//        
//        /// The description of this method, also used by URLRequest.
//        var description: String {
//            switch self {
//            case .GET:
//                return "GET"
//            case .POST(_):
//                return "POST"
//            case .PUT(_):
//                return "PUT"
//            case .PATCH(_):
//                return "PATCH"
//            case .DELETE:
//                return "DELETE"
//            case .OPTIONS:
//                return "OPTIONS"
//            }
//        }
//        
//        /// Optionally, a body to add to the request.
//        var body: Data? {
//            switch self {
//            case .POST(let body), .PUT(let body), .PATCH(let body):
//                return body.data
//            default:
//                return nil
//            }
//        }
//        
//        /// Optionally, the content type to send with the body.
//        var contentType: String? {
//            switch self {
//            case .POST(let body), .PUT(let body), .PATCH(let body):
//                return body.contentType
//            default:
//                return nil
//            }
//        }
//    }
//    
//    enum ParameterEncoding {
//        case formURL, json
//        
//        /// Encode the provided body dictionary to Data.
//        func encode(body: [String: Any]) -> Data? {
//            switch self {
//            case .formURL:
//                return APIUtilities.formURLParameterEncoded(body: body).data(using: .utf8)
//            case .json:
//                return try? JSONSerialization.data(withJSONObject: body)
//            }
//        }
//        
//        /// The default content type to request for this encoding.
//        var contentType: String? {
//            switch self {
//            case .formURL:
//                return "application/x-www-form-urlencoded; charset=utf-8"
//            case .json:
//                return "application/json; charset=utf-8"
//            }
//        }
//    }
//    
//    /// Construct a URL from the provided endpoint and URL parameters.
//    func getURL(with endpoint: String, urlParameters: [String: String?]? = nil) -> URL? {
//        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else { return nil }
//        components.path += endpoint
//        if let params = urlParameters {
//            components.queryItems = params.map { (k, v) in
//                return URLQueryItem(name: k, value: v)
//            }
//        }
//        return components.url
//    }
//    
//    /**
//     Make a request with the provided parameters and return its data as a dictionary, after being decoded from JSON.
//     - parameter endpoint: The endpoint to request (appended to the base URL specified at init).
//     - parameter method: The HTTP method to use (and any data that might be included with this method's body). (defaults to GET)
//     - parameter urlParameters: The URL parameters to use as a query string appended to your URL.
//     - parameter headers: Any additional headers to include with the request. (defaults to none)
//     - parameter completionHandler: A callback accepting two optional parameters of the types [String: AnyObject] (being the received & decoded response) and Error to call upon completion.
//     */
//    func makeRequest(to endpoint: String, method: HTTPMethod = .GET, urlParameters: [String: String?]? = nil, headers: [String: String] = [:], completionHandler: @escaping ([String: AnyObject]?, Error?) -> Void) -> URLSessionDataTask? {
//        guard let url = getURL(with: endpoint, urlParameters: urlParameters) else { completionHandler(nil, nil); return nil }
//        var headers = headers
//        globalHeaders.forEach { (k,v) in headers[k] = v }
//        return VPAPI.makeRequest(to: url, method: method, headers: headers, completionHandler: completionHandler)
//    }
//    
//    /**
//     Make a request with the provided parameters and return its data.
//     - parameter endpoint: The endpoint to request (appended to the base URL specified at init).
//     - parameter method: The HTTP method to use (and any data that might be included with this method's body). (defaults to GET)
//     - parameter urlParameters: The URL parameters to use as a query string appended to your URL.
//     - parameter headers: Any additional headers to include with the request. (defaults to none)
//     - parameter completionHandler: A callback accepting two optional parameters of the types Data (being the received response) and Error to call upon completion.
//     */
//    func makeRawRequest(to endpoint: String, method: HTTPMethod = .GET, urlParameters: [String: String?]? = nil, headers: [String: String] = [:], completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask? {
//        guard let url = getURL(with: endpoint, urlParameters: urlParameters) else { completionHandler(nil, nil); return nil }
//        var headers = headers
//        globalHeaders.forEach { (k,v) in headers[k] = v }
//        return G.makeRawRequest(to: url, method: method, headers: headers, completionHandler: completionHandler)
//    }
//    
//    /**
//     Make a request with the provided parameters and return its data as a dictionary, after being decoded from JSON.
//     - parameter url: The URL to request.
//     - parameter method: The HTTP method to use (and any data that might be included with this method's body). (defaults to GET)
//     - parameter headers: Any additional headers to include with the request. (defaults to none)
//     - parameter completionHandler: A callback accepting two optional parameters of the types [String: AnyObject] (being the received & decoded response) and Error to call upon completion.
//     */
//    static func makeRequest(to url: URL, method: HTTPMethod = .GET, headers: [String: String] = [:], completionHandler: @escaping ([String: AnyObject]?, Error?) -> Void) -> URLSessionDataTask {
//        return VPAPI.makeRawRequest(to: url, method: method, headers: headers) { data, error in
//            guard let data = data else { completionHandler(nil, error); return }
//            completionHandler((try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: AnyObject], error)
//        }
//    }
//    
//    /**
//     Make a request with the provided parameters and return its data.
//     - parameter url: The URL to request.
//     - parameter method: The HTTP method to use (and any data that might be included with this method's body). (defaults to GET)
//     - parameter headers: Any additional headers to include with the request. (defaults to none)
//     - parameter completionHandler: A callback accepting two optional parameters of the types Data (being the received response) and Error to call upon completion.
//     */
//    static func makeRawRequest(to url: URL, method: HTTPMethod = .GET, headers: [String: String] = [:], completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
//        // Construct the request
//        if isInDebugMode { print("Making \(method) request to \(url.absoluteString)") }
//        
//        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
//        request.httpMethod = method.description
//        request.httpBody = method.body
//        request.addValue(GiphyAPI.userAgentString, forHTTPHeaderField: "User-Agent")
//        if let contentType = method.contentType {
//            request.addValue(contentType, forHTTPHeaderField: "Content-Type")
//        }
//        for (name, value) in headers {
//            request.addValue(value, forHTTPHeaderField: name)
//        }
//        
//        // Do the request!
//        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            completionHandler(data, error)
//        })
//        task.resume()
//        return task
//    }
//    
//    /// A dynamically-generated user agent string to use in case one isn't specified (AppName/AppVersion).
//    static var userAgentString: String {
//        var userAgentString = "App"
//        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
//            userAgentString = bundleDisplayName
//        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
//            userAgentString = bundleName
//        }
//        if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
//            userAgentString += "/\(version)"
//        }
//        return userAgentString
//    }
//    
//}
//
//struct APIUtilities {
//    /// Encode the provided body using form URL parameter encoding and return it as a string.
//    static func formURLParameterEncoded(body: [String: Any]) -> String {
//        var result = [String]()
//        for (name, value) in body {
//            if let nameEncoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let valueEncoded = String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//                result.append("\(nameEncoded)=\(valueEncoded)")
//            }
//        }
//        let resultStr = result.joined(separator: "&")
//        return resultStr
//    }
//}
//
//
