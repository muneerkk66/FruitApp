//
//  FruitAnalyticsAPIHandler.swift
//  FruiteApp
//
//  Created by Muneer KK on 07/08/21.
//

import Foundation

struct BBCAnalytics {
    static func trackEvent(event: EventType, metaData: [EventProperty]) {
        let event = BBCAnalyticsEvent(event: event, metaData: metaData, date: Date())
        FruitAnalyticsSessionManager.shared.queueEvent(event)
    }
    
    static func start() {
        FruitAnalyticsSessionManager.shared.start()
    }
}

class FruitAnalyticsSessionManager {
    
    // MARK: - vars
    static let shared = FruitAnalyticsSessionManager()
    
    private let baseURL: URL!
    
    private let urlSession = URLSession(configuration: .default)
    
    // MARK: - Operation queue to help batch upload data
    private let operationQueue = OperationQueue()
    private var queue = Queue<BBCAnalyticsEvent>()
    
    private var timer: Timer?
    
    // MARK: - Initialisation
    private init() {
        self.baseURL = URL(string: AppConstants.Configuration.baseURL(path: "stats"))!
        operationQueue.maxConcurrentOperationCount = 1
    }
    
    // MARK: - Public methods
    func queueEvent(_ event: BBCAnalyticsEvent) {
        queue.enqueue(event)
    }
    
    func pause() {
        // TODO: implement
    }
    
    func stop() {
        self.timer?.invalidate()
    }
    
    func start() {
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(executeSync), userInfo: nil, repeats: true)
        }
    }
    
    func resume() {
        // TODO: implement
    }
    
    // MARK: - Private methods
    private let syncQueue = DispatchQueue(label: "uk.co.bbc.background.queue.sync", attributes: .concurrent)
    private var synchingQueue = [BBCAnalyticsEvent]()
    @objc private func executeSync() {
        self.syncQueue.sync {
            if queue.isEmpty() == false {
                // Take first 10 to sync
                for _ in 1...10 {
                    if let event = queue.dequeue() {
                        synchingQueue.append(event)
                        
                        let url = (event.url(baseURL: baseURL))!
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET"
                        
                        let operation = PushAnalyticsOperation(session: urlSession, request: request, event: event, completion: { (event, data, response, error) -> (Void) in
                            
                            // assume all went well and remove
                            // in actuality you will want to queue again for retry
                            
                            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                            if statusCode != 200 {
                                let string = String(data: data!, encoding: .utf8)
                                print("Server error \(String(describing: string))")
                            }
                            
                            if let index = self.synchingQueue.index(where: { (e) -> Bool in
                                e == event
                            }) {
                                 self.synchingQueue.remove(at: index)
                            }
                        })
                        operationQueue.addOperation(operation)
                    }
                }
            }
        }
    }
}

struct Queue<T> {
    fileprivate var queue = [T]()
    
    mutating func enqueue(_ item: T) {
        self.queue.insert(item, at: self.queue.count)
    }
    
    mutating func dequeue() -> T? {
        guard !isEmpty() else {
            return nil
        }
        return self.queue.remove(at: 0)
    }
    
    func count() -> Int {
        return self.queue.count
    }
    
    func isEmpty() -> Bool {
        return queue.count == 0
    }
}

class PushAnalyticsOperation : Operation {
    
    private var task : URLSessionDataTask!
    
    enum OperationState : Int {
        case ready
        case executing
        case finished
    }
    
    // default state is ready (when the operation is created)
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
    
    init(session: URLSession, request: URLRequest, event: BBCAnalyticsEvent, completion: ((BBCAnalyticsEvent, Data?, URLResponse?, Error?) -> (Void))?) {
        super.init()
        
        task = session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            if let completion = completion {
                completion(event, data, response, error)
            }

            self?.state = .finished
        })
    }
    
    override func start() {

        if(self.isCancelled) {
            state = .finished
            return
        }

        state = .executing
        
        print("Logged event \(self.task.originalRequest?.url?.absoluteString ?? "")")
        
        self.task.resume()
    }
    
    override func cancel() {
        super.cancel()

        self.task.cancel()
    }
}

