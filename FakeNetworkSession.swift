//
//  FakeNetworkSession.swift
//  Menu
//
//  Created by Alice Hyun on 11/10/21.
//  Copyright © 2021 DoorDash, Inc. All rights reserved.
//

import Foundation
import Combine

var fileURL: URL {
    let path = Bundle.main.path(forResource: "Response", ofType: "json")!
    return URL(fileURLWithPath: path)
}

/// Candidates should not modify this class
class FakeNetworkSession {
    private static let queue = DispatchQueue(label: "com.doordash.random-queue", qos: .background)
    
    /// Candidates should not modify this property
    let networkCall = FakeNetworkPublisher(fileURL: fileURL).subscribe(on: FakeNetworkSession.queue)
    
    /// Candidates should not modify this method
    func networkTask(completionHandler: @escaping (Data) -> Void) {
        FakeNetworkSession.queue.async {
            let data = try! Data(contentsOf: fileURL)
            completionHandler(data)
        }
    }
}

/// Candidates should not modify this class
struct FakeNetworkPublisher: Publisher {
    typealias Output = Data
    typealias Failure = Error
    
    let fileURL: URL
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = FileSubscription(fileURL: fileURL, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

/// Candidates should not modify this class
private class FileSubscription<S: Subscriber>: Subscription where S.Input == Data, S.Failure == Error {
    private let fileURL: URL
    private var subscriber: S?

    init(fileURL: URL, subscriber: S) {
        self.fileURL = fileURL
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        if demand > 0 {
            do {
                let data = try Data(contentsOf: fileURL)
                _ = subscriber?.receive(data)
                subscriber?.receive(completion: .finished)
            } catch {
                subscriber?.receive(completion: .failure(error))
            }
        }
    }
    
    func cancel() {
        subscriber = nil
    }
}
