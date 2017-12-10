// Copyright © 2015 Giuseppe Morana aka Eugenio
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
@testable import GMIRCClient

class GMSocketStub: NSObject, GMSocketProtocol {
    
    weak var delegate: GMSocketDelegate?
    
    fileprivate(set) var host: String
    fileprivate(set) var port: Int
    
    /// Fake response map
    fileprivate var _responseMap: [String: String]
    
    required init(host: String, port: Int) {
        self.host = host
        self.port = port
        _responseMap = [String: String]()
    }
    
    func open() {
        delegate?.didOpen()
        delegate?.didReadyToSendMessages()
    }
    
    func close() {
        delegate?.didClose()
    }
    
    func sendMessage(_ message: String) {
        if let response = _responseMap[message] {
            delegate?.didReceiveMessage(response)
        }
    }
    
    // fake method - you can establish which response you want at a specified message
    func responseToMessage(_ msg: String, response: String) {
        _responseMap[msg + "\r\n"] = response
    }
}
