// MARK: - Mocks generated from file: QLog/AppsTableViewController.swift at 2019-06-12 18:03:46 +0000

//
//  AppsTableViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 02.08.17.
//  Copyright © 2017 Quantum. All rights reserved.
//
import Cuckoo
@testable import QLog

import UIKit


 class MockAppsTableViewControllerDelegate: AppsTableViewControllerDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = AppsTableViewControllerDelegate
    
     typealias Stubbing = __StubbingProxy_AppsTableViewControllerDelegate
     typealias Verification = __VerificationProxy_AppsTableViewControllerDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AppsTableViewControllerDelegate?

     func enableDefaultImplementation(_ stub: AppsTableViewControllerDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func back()  {
        
    return cuckoo_manager.call("back()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.back())
        
    }
    
    
    
     func show(_ app: URL)  {
        
    return cuckoo_manager.call("show(_: URL)",
            parameters: (app),
            escapingParameters: (app),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.show(app))
        
    }
    

	 struct __StubbingProxy_AppsTableViewControllerDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func back() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewControllerDelegate.self, method: "back()", parameterMatchers: matchers))
	    }
	    
	    func show<M1: Cuckoo.Matchable>(_ app: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(URL)> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: app) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewControllerDelegate.self, method: "show(_: URL)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AppsTableViewControllerDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func back() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("back()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func show<M1: Cuckoo.Matchable>(_ app: M1) -> Cuckoo.__DoNotUse<(URL), Void> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: app) { $0 }]
	        return cuckoo_manager.verify("show(_: URL)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AppsTableViewControllerDelegateStub: AppsTableViewControllerDelegate {
    

    

    
     func back()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func show(_ app: URL)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockAppsTableViewController: AppsTableViewController, Cuckoo.ClassMock {
    
     typealias MocksType = AppsTableViewController
    
     typealias Stubbing = __StubbingProxy_AppsTableViewController
     typealias Verification = __VerificationProxy_AppsTableViewController

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: AppsTableViewController?

     func enableDefaultImplementation(_ stub: AppsTableViewController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var apps: [URL] {
        get {
            return cuckoo_manager.getter("apps",
                superclassCall:
                    
                    super.apps
                    ,
                defaultCall: __defaultImplStub!.apps)
        }
        
        set {
            cuckoo_manager.setter("apps",
                value: newValue,
                superclassCall:
                    
                    super.apps = newValue
                    ,
                defaultCall: __defaultImplStub!.apps = newValue)
        }
        
    }
    
    
    
     override var delegate: AppsTableViewControllerDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    super.delegate
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    super.delegate = newValue
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    

    

    
    
    
     override func viewDidLoad()  {
        
    return cuckoo_manager.call("viewDidLoad()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.viewDidLoad()
                ,
            defaultCall: __defaultImplStub!.viewDidLoad())
        
    }
    
    
    
     override func numberOfSections(in tableView: UITableView) -> Int {
        
    return cuckoo_manager.call("numberOfSections(in: UITableView) -> Int",
            parameters: (tableView),
            escapingParameters: (tableView),
            superclassCall:
                
                super.numberOfSections(in: tableView)
                ,
            defaultCall: __defaultImplStub!.numberOfSections(in: tableView))
        
    }
    
    
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    return cuckoo_manager.call("tableView(_: UITableView, numberOfRowsInSection: Int) -> Int",
            parameters: (tableView, section),
            escapingParameters: (tableView, section),
            superclassCall:
                
                super.tableView(tableView, numberOfRowsInSection: section)
                ,
            defaultCall: __defaultImplStub!.tableView(tableView, numberOfRowsInSection: section))
        
    }
    
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    return cuckoo_manager.call("tableView(_: UITableView, cellForRowAt: IndexPath) -> UITableViewCell",
            parameters: (tableView, indexPath),
            escapingParameters: (tableView, indexPath),
            superclassCall:
                
                super.tableView(tableView, cellForRowAt: indexPath)
                ,
            defaultCall: __defaultImplStub!.tableView(tableView, cellForRowAt: indexPath))
        
    }
    
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
    return cuckoo_manager.call("tableView(_: UITableView, didSelectRowAt: IndexPath)",
            parameters: (tableView, indexPath),
            escapingParameters: (tableView, indexPath),
            superclassCall:
                
                super.tableView(tableView, didSelectRowAt: indexPath)
                ,
            defaultCall: __defaultImplStub!.tableView(tableView, didSelectRowAt: indexPath))
        
    }
    
    
    
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
    return cuckoo_manager.call("tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat",
            parameters: (tableView, indexPath),
            escapingParameters: (tableView, indexPath),
            superclassCall:
                
                super.tableView(tableView, heightForRowAt: indexPath)
                ,
            defaultCall: __defaultImplStub!.tableView(tableView, heightForRowAt: indexPath))
        
    }
    
    
    
     override func back()  {
        
    return cuckoo_manager.call("back()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.back()
                ,
            defaultCall: __defaultImplStub!.back())
        
    }
    

	 struct __StubbingProxy_AppsTableViewController: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var apps: Cuckoo.ClassToBeStubbedProperty<MockAppsTableViewController, [URL]> {
	        return .init(manager: cuckoo_manager, name: "apps")
	    }
	    
	    
	    var delegate: Cuckoo.ClassToBeStubbedOptionalProperty<MockAppsTableViewController, AppsTableViewControllerDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    func viewDidLoad() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "viewDidLoad()", parameterMatchers: matchers))
	    }
	    
	    func numberOfSections<M1: Cuckoo.Matchable>(in tableView: M1) -> Cuckoo.ClassStubFunction<(UITableView), Int> where M1.MatchedType == UITableView {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView)>] = [wrap(matchable: tableView) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "numberOfSections(in: UITableView) -> Int", parameterMatchers: matchers))
	    }
	    
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, numberOfRowsInSection section: M2) -> Cuckoo.ClassStubFunction<(UITableView, Int), Int> where M1.MatchedType == UITableView, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, Int)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: section) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "tableView(_: UITableView, numberOfRowsInSection: Int) -> Int", parameterMatchers: matchers))
	    }
	    
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, cellForRowAt indexPath: M2) -> Cuckoo.ClassStubFunction<(UITableView, IndexPath), UITableViewCell> where M1.MatchedType == UITableView, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, IndexPath)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: indexPath) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "tableView(_: UITableView, cellForRowAt: IndexPath) -> UITableViewCell", parameterMatchers: matchers))
	    }
	    
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, didSelectRowAt indexPath: M2) -> Cuckoo.ClassStubNoReturnFunction<(UITableView, IndexPath)> where M1.MatchedType == UITableView, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, IndexPath)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: indexPath) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "tableView(_: UITableView, didSelectRowAt: IndexPath)", parameterMatchers: matchers))
	    }
	    
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, heightForRowAt indexPath: M2) -> Cuckoo.ClassStubFunction<(UITableView, IndexPath), CGFloat> where M1.MatchedType == UITableView, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, IndexPath)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: indexPath) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat", parameterMatchers: matchers))
	    }
	    
	    func back() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockAppsTableViewController.self, method: "back()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AppsTableViewController: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var apps: Cuckoo.VerifyProperty<[URL]> {
	        return .init(manager: cuckoo_manager, name: "apps", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var delegate: Cuckoo.VerifyOptionalProperty<AppsTableViewControllerDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func viewDidLoad() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("viewDidLoad()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func numberOfSections<M1: Cuckoo.Matchable>(in tableView: M1) -> Cuckoo.__DoNotUse<(UITableView), Int> where M1.MatchedType == UITableView {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView)>] = [wrap(matchable: tableView) { $0 }]
	        return cuckoo_manager.verify("numberOfSections(in: UITableView) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, numberOfRowsInSection section: M2) -> Cuckoo.__DoNotUse<(UITableView, Int), Int> where M1.MatchedType == UITableView, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, Int)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: section) { $0.1 }]
	        return cuckoo_manager.verify("tableView(_: UITableView, numberOfRowsInSection: Int) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, cellForRowAt indexPath: M2) -> Cuckoo.__DoNotUse<(UITableView, IndexPath), UITableViewCell> where M1.MatchedType == UITableView, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, IndexPath)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: indexPath) { $0.1 }]
	        return cuckoo_manager.verify("tableView(_: UITableView, cellForRowAt: IndexPath) -> UITableViewCell", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, didSelectRowAt indexPath: M2) -> Cuckoo.__DoNotUse<(UITableView, IndexPath), Void> where M1.MatchedType == UITableView, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, IndexPath)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: indexPath) { $0.1 }]
	        return cuckoo_manager.verify("tableView(_: UITableView, didSelectRowAt: IndexPath)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func tableView<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ tableView: M1, heightForRowAt indexPath: M2) -> Cuckoo.__DoNotUse<(UITableView, IndexPath), CGFloat> where M1.MatchedType == UITableView, M2.MatchedType == IndexPath {
	        let matchers: [Cuckoo.ParameterMatcher<(UITableView, IndexPath)>] = [wrap(matchable: tableView) { $0.0 }, wrap(matchable: indexPath) { $0.1 }]
	        return cuckoo_manager.verify("tableView(_: UITableView, heightForRowAt: IndexPath) -> CGFloat", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func back() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("back()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AppsTableViewControllerStub: AppsTableViewController {
    
    
     override var apps: [URL] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([URL]).self)
        }
        
        set { }
        
    }
    
    
     override var delegate: AppsTableViewControllerDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (AppsTableViewControllerDelegate?).self)
        }
        
        set { }
        
    }
    

    

    
     override func viewDidLoad()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func numberOfSections(in tableView: UITableView) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        return DefaultValueRegistry.defaultValue(for: (UITableViewCell).self)
    }
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {
        return DefaultValueRegistry.defaultValue(for: (CGFloat).self)
    }
    
     override func back()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: QLog/LiveLogCoordinator.swift at 2019-06-12 18:03:46 +0000

//
//  LiveLogCoordinator.swift
//  QLog
//
//  Created by Christian Oberdörfer on 26.02.19.
//  Copyright © 2019 Quantum. All rights reserved.
//
import Cuckoo
@testable import QLog

import Foundation
import MobileCoreServices


 class MockLiveLogCoordinator: LiveLogCoordinator, Cuckoo.ClassMock {
    
     typealias MocksType = LiveLogCoordinator
    
     typealias Stubbing = __StubbingProxy_LiveLogCoordinator
     typealias Verification = __VerificationProxy_LiveLogCoordinator

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LiveLogCoordinator?

     func enableDefaultImplementation(_ stub: LiveLogCoordinator) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func start()  {
        
    return cuckoo_manager.call("start()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.start()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
     override func log(_ logEntry: LogEntry)  {
        
    return cuckoo_manager.call("log(_: LogEntry)",
            parameters: (logEntry),
            escapingParameters: (logEntry),
            superclassCall:
                
                super.log(logEntry)
                ,
            defaultCall: __defaultImplStub!.log(logEntry))
        
    }
    

	 struct __StubbingProxy_LiveLogCoordinator: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func start() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogCoordinator.self, method: "start()", parameterMatchers: matchers))
	    }
	    
	    func log<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.ClassStubNoReturnFunction<(LogEntry)> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogCoordinator.self, method: "log(_: LogEntry)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LiveLogCoordinator: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func start() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("start()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func log<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.__DoNotUse<(LogEntry), Void> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return cuckoo_manager.verify("log(_: LogEntry)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LiveLogCoordinatorStub: LiveLogCoordinator {
    

    

    
     override func start()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func log(_ logEntry: LogEntry)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: QLog/LiveLogViewController.swift at 2019-06-12 18:03:46 +0000

//
//  LiveLogViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//
import Cuckoo
@testable import QLog

import UIKit


 class MockLiveLogViewControllerDelegate: LiveLogViewControllerDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = LiveLogViewControllerDelegate
    
     typealias Stubbing = __StubbingProxy_LiveLogViewControllerDelegate
     typealias Verification = __VerificationProxy_LiveLogViewControllerDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: LiveLogViewControllerDelegate?

     func enableDefaultImplementation(_ stub: LiveLogViewControllerDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func back()  {
        
    return cuckoo_manager.call("back()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.back())
        
    }
    
    
    
     func action(sender: UIBarButtonItem)  {
        
    return cuckoo_manager.call("action(sender: UIBarButtonItem)",
            parameters: (sender),
            escapingParameters: (sender),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.action(sender: sender))
        
    }
    

	 struct __StubbingProxy_LiveLogViewControllerDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func back() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewControllerDelegate.self, method: "back()", parameterMatchers: matchers))
	    }
	    
	    func action<M1: Cuckoo.Matchable>(sender: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(UIBarButtonItem)> where M1.MatchedType == UIBarButtonItem {
	        let matchers: [Cuckoo.ParameterMatcher<(UIBarButtonItem)>] = [wrap(matchable: sender) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewControllerDelegate.self, method: "action(sender: UIBarButtonItem)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LiveLogViewControllerDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func back() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("back()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func action<M1: Cuckoo.Matchable>(sender: M1) -> Cuckoo.__DoNotUse<(UIBarButtonItem), Void> where M1.MatchedType == UIBarButtonItem {
	        let matchers: [Cuckoo.ParameterMatcher<(UIBarButtonItem)>] = [wrap(matchable: sender) { $0 }]
	        return cuckoo_manager.verify("action(sender: UIBarButtonItem)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LiveLogViewControllerDelegateStub: LiveLogViewControllerDelegate {
    

    

    
     func back()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func action(sender: UIBarButtonItem)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockLiveLogViewController: LiveLogViewController, Cuckoo.ClassMock {
    
     typealias MocksType = LiveLogViewController
    
     typealias Stubbing = __StubbingProxy_LiveLogViewController
     typealias Verification = __VerificationProxy_LiveLogViewController

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: LiveLogViewController?

     func enableDefaultImplementation(_ stub: LiveLogViewController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var scrollView: UIScrollView! {
        get {
            return cuckoo_manager.getter("scrollView",
                superclassCall:
                    
                    super.scrollView
                    ,
                defaultCall: __defaultImplStub!.scrollView)
        }
        
        set {
            cuckoo_manager.setter("scrollView",
                value: newValue,
                superclassCall:
                    
                    super.scrollView = newValue
                    ,
                defaultCall: __defaultImplStub!.scrollView = newValue)
        }
        
    }
    
    
    
     override var contentView: UIView! {
        get {
            return cuckoo_manager.getter("contentView",
                superclassCall:
                    
                    super.contentView
                    ,
                defaultCall: __defaultImplStub!.contentView)
        }
        
        set {
            cuckoo_manager.setter("contentView",
                value: newValue,
                superclassCall:
                    
                    super.contentView = newValue
                    ,
                defaultCall: __defaultImplStub!.contentView = newValue)
        }
        
    }
    
    
    
     override var logLevelSegmentedControl: UISegmentedControl! {
        get {
            return cuckoo_manager.getter("logLevelSegmentedControl",
                superclassCall:
                    
                    super.logLevelSegmentedControl
                    ,
                defaultCall: __defaultImplStub!.logLevelSegmentedControl)
        }
        
        set {
            cuckoo_manager.setter("logLevelSegmentedControl",
                value: newValue,
                superclassCall:
                    
                    super.logLevelSegmentedControl = newValue
                    ,
                defaultCall: __defaultImplStub!.logLevelSegmentedControl = newValue)
        }
        
    }
    
    
    
     override var logLevelSegmentedControlHeight: NSLayoutConstraint! {
        get {
            return cuckoo_manager.getter("logLevelSegmentedControlHeight",
                superclassCall:
                    
                    super.logLevelSegmentedControlHeight
                    ,
                defaultCall: __defaultImplStub!.logLevelSegmentedControlHeight)
        }
        
        set {
            cuckoo_manager.setter("logLevelSegmentedControlHeight",
                value: newValue,
                superclassCall:
                    
                    super.logLevelSegmentedControlHeight = newValue
                    ,
                defaultCall: __defaultImplStub!.logLevelSegmentedControlHeight = newValue)
        }
        
    }
    
    
    
     override var textView: UITextView! {
        get {
            return cuckoo_manager.getter("textView",
                superclassCall:
                    
                    super.textView
                    ,
                defaultCall: __defaultImplStub!.textView)
        }
        
        set {
            cuckoo_manager.setter("textView",
                value: newValue,
                superclassCall:
                    
                    super.textView = newValue
                    ,
                defaultCall: __defaultImplStub!.textView = newValue)
        }
        
    }
    
    
    
     override var delegate: LiveLogViewControllerDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    super.delegate
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    super.delegate = newValue
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    

    

    
    
    
     override func log(_ logEntry: LogEntry)  {
        
    return cuckoo_manager.call("log(_: LogEntry)",
            parameters: (logEntry),
            escapingParameters: (logEntry),
            superclassCall:
                
                super.log(logEntry)
                ,
            defaultCall: __defaultImplStub!.log(logEntry))
        
    }
    
    
    
     override func showLog(_ logUrl: URL)  {
        
    return cuckoo_manager.call("showLog(_: URL)",
            parameters: (logUrl),
            escapingParameters: (logUrl),
            superclassCall:
                
                super.showLog(logUrl)
                ,
            defaultCall: __defaultImplStub!.showLog(logUrl))
        
    }
    
    
    
     override func scroll()  {
        
    return cuckoo_manager.call("scroll()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.scroll()
                ,
            defaultCall: __defaultImplStub!.scroll())
        
    }
    
    
    
     override func logLevelSegmentedControlValueChanged(_ sender: Any)  {
        
    return cuckoo_manager.call("logLevelSegmentedControlValueChanged(_: Any)",
            parameters: (sender),
            escapingParameters: (sender),
            superclassCall:
                
                super.logLevelSegmentedControlValueChanged(sender)
                ,
            defaultCall: __defaultImplStub!.logLevelSegmentedControlValueChanged(sender))
        
    }
    
    
    
     override func back()  {
        
    return cuckoo_manager.call("back()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.back()
                ,
            defaultCall: __defaultImplStub!.back())
        
    }
    
    
    
     override func action(_ sender: UIBarButtonItem)  {
        
    return cuckoo_manager.call("action(_: UIBarButtonItem)",
            parameters: (sender),
            escapingParameters: (sender),
            superclassCall:
                
                super.action(sender)
                ,
            defaultCall: __defaultImplStub!.action(sender))
        
    }
    

	 struct __StubbingProxy_LiveLogViewController: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var scrollView: Cuckoo.ClassToBeStubbedOptionalProperty<MockLiveLogViewController, UIScrollView> {
	        return .init(manager: cuckoo_manager, name: "scrollView")
	    }
	    
	    
	    var contentView: Cuckoo.ClassToBeStubbedOptionalProperty<MockLiveLogViewController, UIView> {
	        return .init(manager: cuckoo_manager, name: "contentView")
	    }
	    
	    
	    var logLevelSegmentedControl: Cuckoo.ClassToBeStubbedOptionalProperty<MockLiveLogViewController, UISegmentedControl> {
	        return .init(manager: cuckoo_manager, name: "logLevelSegmentedControl")
	    }
	    
	    
	    var logLevelSegmentedControlHeight: Cuckoo.ClassToBeStubbedOptionalProperty<MockLiveLogViewController, NSLayoutConstraint> {
	        return .init(manager: cuckoo_manager, name: "logLevelSegmentedControlHeight")
	    }
	    
	    
	    var textView: Cuckoo.ClassToBeStubbedOptionalProperty<MockLiveLogViewController, UITextView> {
	        return .init(manager: cuckoo_manager, name: "textView")
	    }
	    
	    
	    var delegate: Cuckoo.ClassToBeStubbedOptionalProperty<MockLiveLogViewController, LiveLogViewControllerDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    func log<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.ClassStubNoReturnFunction<(LogEntry)> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewController.self, method: "log(_: LogEntry)", parameterMatchers: matchers))
	    }
	    
	    func showLog<M1: Cuckoo.Matchable>(_ logUrl: M1) -> Cuckoo.ClassStubNoReturnFunction<(URL)> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: logUrl) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewController.self, method: "showLog(_: URL)", parameterMatchers: matchers))
	    }
	    
	    func scroll() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewController.self, method: "scroll()", parameterMatchers: matchers))
	    }
	    
	    func logLevelSegmentedControlValueChanged<M1: Cuckoo.Matchable>(_ sender: M1) -> Cuckoo.ClassStubNoReturnFunction<(Any)> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: sender) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewController.self, method: "logLevelSegmentedControlValueChanged(_: Any)", parameterMatchers: matchers))
	    }
	    
	    func back() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewController.self, method: "back()", parameterMatchers: matchers))
	    }
	    
	    func action<M1: Cuckoo.Matchable>(_ sender: M1) -> Cuckoo.ClassStubNoReturnFunction<(UIBarButtonItem)> where M1.MatchedType == UIBarButtonItem {
	        let matchers: [Cuckoo.ParameterMatcher<(UIBarButtonItem)>] = [wrap(matchable: sender) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLiveLogViewController.self, method: "action(_: UIBarButtonItem)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_LiveLogViewController: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var scrollView: Cuckoo.VerifyOptionalProperty<UIScrollView> {
	        return .init(manager: cuckoo_manager, name: "scrollView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var contentView: Cuckoo.VerifyOptionalProperty<UIView> {
	        return .init(manager: cuckoo_manager, name: "contentView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var logLevelSegmentedControl: Cuckoo.VerifyOptionalProperty<UISegmentedControl> {
	        return .init(manager: cuckoo_manager, name: "logLevelSegmentedControl", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var logLevelSegmentedControlHeight: Cuckoo.VerifyOptionalProperty<NSLayoutConstraint> {
	        return .init(manager: cuckoo_manager, name: "logLevelSegmentedControlHeight", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var textView: Cuckoo.VerifyOptionalProperty<UITextView> {
	        return .init(manager: cuckoo_manager, name: "textView", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var delegate: Cuckoo.VerifyOptionalProperty<LiveLogViewControllerDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func log<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.__DoNotUse<(LogEntry), Void> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return cuckoo_manager.verify("log(_: LogEntry)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showLog<M1: Cuckoo.Matchable>(_ logUrl: M1) -> Cuckoo.__DoNotUse<(URL), Void> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: logUrl) { $0 }]
	        return cuckoo_manager.verify("showLog(_: URL)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func scroll() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("scroll()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func logLevelSegmentedControlValueChanged<M1: Cuckoo.Matchable>(_ sender: M1) -> Cuckoo.__DoNotUse<(Any), Void> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: sender) { $0 }]
	        return cuckoo_manager.verify("logLevelSegmentedControlValueChanged(_: Any)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func back() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("back()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func action<M1: Cuckoo.Matchable>(_ sender: M1) -> Cuckoo.__DoNotUse<(UIBarButtonItem), Void> where M1.MatchedType == UIBarButtonItem {
	        let matchers: [Cuckoo.ParameterMatcher<(UIBarButtonItem)>] = [wrap(matchable: sender) { $0 }]
	        return cuckoo_manager.verify("action(_: UIBarButtonItem)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class LiveLogViewControllerStub: LiveLogViewController {
    
    
     override var scrollView: UIScrollView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIScrollView?).self)
        }
        
        set { }
        
    }
    
    
     override var contentView: UIView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIView?).self)
        }
        
        set { }
        
    }
    
    
     override var logLevelSegmentedControl: UISegmentedControl! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UISegmentedControl?).self)
        }
        
        set { }
        
    }
    
    
     override var logLevelSegmentedControlHeight: NSLayoutConstraint! {
        get {
            return DefaultValueRegistry.defaultValue(for: (NSLayoutConstraint?).self)
        }
        
        set { }
        
    }
    
    
     override var textView: UITextView! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UITextView?).self)
        }
        
        set { }
        
    }
    
    
     override var delegate: LiveLogViewControllerDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (LiveLogViewControllerDelegate?).self)
        }
        
        set { }
        
    }
    

    

    
     override func log(_ logEntry: LogEntry)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func showLog(_ logUrl: URL)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func scroll()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func logLevelSegmentedControlValueChanged(_ sender: Any)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func back()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func action(_ sender: UIBarButtonItem)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: QLog/Logger.swift at 2019-06-12 18:03:46 +0000

//
//  Logger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

/**
 Logger protocol
 */

import Cuckoo
@testable import QLog


public class MockLogger: Logger, Cuckoo.ProtocolMock {
    
    public typealias MocksType = Logger
    
    public typealias Stubbing = __StubbingProxy_Logger
    public typealias Verification = __VerificationProxy_Logger

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: Logger?

    public func enableDefaultImplementation(_ stub: Logger) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var logLevel: LogLevel {
        get {
            return cuckoo_manager.getter("logLevel",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.logLevel)
        }
        
        set {
            cuckoo_manager.setter("logLevel",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.logLevel = newValue)
        }
        
    }
    

    

    
    
    
    public func doLog(_ logEntry: LogEntry)  {
        
    return cuckoo_manager.call("doLog(_: LogEntry)",
            parameters: (logEntry),
            escapingParameters: (logEntry),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.doLog(logEntry))
        
    }
    

	public struct __StubbingProxy_Logger: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var logLevel: Cuckoo.ProtocolToBeStubbedProperty<MockLogger, LogLevel> {
	        return .init(manager: cuckoo_manager, name: "logLevel")
	    }
	    
	    
	    func doLog<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(LogEntry)> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockLogger.self, method: "doLog(_: LogEntry)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_Logger: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var logLevel: Cuckoo.VerifyProperty<LogLevel> {
	        return .init(manager: cuckoo_manager, name: "logLevel", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func doLog<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.__DoNotUse<(LogEntry), Void> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return cuckoo_manager.verify("doLog(_: LogEntry)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class LoggerStub: Logger {
    
    
    public var logLevel: LogLevel {
        get {
            return DefaultValueRegistry.defaultValue(for: (LogLevel).self)
        }
        
        set { }
        
    }
    

    

    
    public func doLog(_ logEntry: LogEntry)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: QLog/QLog.swift at 2019-06-12 18:03:46 +0000

//
//  QLog.swift
//  QLog
//
//  Created by Christian Oberdörfer on 21.06.17.
//  Copyright © 2017 Quantum. All rights reserved.
//
import Cuckoo
@testable import QLog

import MobileCoreServices
import Zip


public class MockQLog: QLog, Cuckoo.ClassMock {
    
    public typealias MocksType = QLog
    
    public typealias Stubbing = __StubbingProxy_QLog
    public typealias Verification = __VerificationProxy_QLog

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: QLog?

    public func enableDefaultImplementation(_ stub: QLog) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

	public struct __StubbingProxy_QLog: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	}

	public struct __VerificationProxy_QLog: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	}
}

public class QLogStub: QLog {
    

    

    
}


// MARK: - Mocks generated from file: QLog/SupportPackageViewController.swift at 2019-06-12 18:03:46 +0000

//
//  SupportPackageViewController.swift
//  QLog
//
//  Created by Christian Oberdörfer on 20.09.17.
//  Copyright © 2017 Quantum. All rights reserved.
//
import Cuckoo
@testable import QLog

import UIKit


 class MockSupportPackageViewControllerDelegate: SupportPackageViewControllerDelegate, Cuckoo.ProtocolMock {
    
     typealias MocksType = SupportPackageViewControllerDelegate
    
     typealias Stubbing = __StubbingProxy_SupportPackageViewControllerDelegate
     typealias Verification = __VerificationProxy_SupportPackageViewControllerDelegate

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: SupportPackageViewControllerDelegate?

     func enableDefaultImplementation(_ stub: SupportPackageViewControllerDelegate) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func back()  {
        
    return cuckoo_manager.call("back()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.back())
        
    }
    
    
    
     func generateSupportPackage()  {
        
    return cuckoo_manager.call("generateSupportPackage()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.generateSupportPackage())
        
    }
    

	 struct __StubbingProxy_SupportPackageViewControllerDelegate: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func back() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSupportPackageViewControllerDelegate.self, method: "back()", parameterMatchers: matchers))
	    }
	    
	    func generateSupportPackage() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSupportPackageViewControllerDelegate.self, method: "generateSupportPackage()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SupportPackageViewControllerDelegate: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func back() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("back()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func generateSupportPackage() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("generateSupportPackage()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SupportPackageViewControllerDelegateStub: SupportPackageViewControllerDelegate {
    

    

    
     func back()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func generateSupportPackage()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockSupportPackageViewController: SupportPackageViewController, Cuckoo.ClassMock {
    
     typealias MocksType = SupportPackageViewController
    
     typealias Stubbing = __StubbingProxy_SupportPackageViewController
     typealias Verification = __VerificationProxy_SupportPackageViewController

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: SupportPackageViewController?

     func enableDefaultImplementation(_ stub: SupportPackageViewController) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var generateSupportPackageButton: UIButton! {
        get {
            return cuckoo_manager.getter("generateSupportPackageButton",
                superclassCall:
                    
                    super.generateSupportPackageButton
                    ,
                defaultCall: __defaultImplStub!.generateSupportPackageButton)
        }
        
        set {
            cuckoo_manager.setter("generateSupportPackageButton",
                value: newValue,
                superclassCall:
                    
                    super.generateSupportPackageButton = newValue
                    ,
                defaultCall: __defaultImplStub!.generateSupportPackageButton = newValue)
        }
        
    }
    
    
    
     override var delegate: SupportPackageViewControllerDelegate? {
        get {
            return cuckoo_manager.getter("delegate",
                superclassCall:
                    
                    super.delegate
                    ,
                defaultCall: __defaultImplStub!.delegate)
        }
        
        set {
            cuckoo_manager.setter("delegate",
                value: newValue,
                superclassCall:
                    
                    super.delegate = newValue
                    ,
                defaultCall: __defaultImplStub!.delegate = newValue)
        }
        
    }
    

    

    
    
    
     override func back()  {
        
    return cuckoo_manager.call("back()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.back()
                ,
            defaultCall: __defaultImplStub!.back())
        
    }
    
    
    
     override func generateSupportPackage(_ sender: Any)  {
        
    return cuckoo_manager.call("generateSupportPackage(_: Any)",
            parameters: (sender),
            escapingParameters: (sender),
            superclassCall:
                
                super.generateSupportPackage(sender)
                ,
            defaultCall: __defaultImplStub!.generateSupportPackage(sender))
        
    }
    

	 struct __StubbingProxy_SupportPackageViewController: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var generateSupportPackageButton: Cuckoo.ClassToBeStubbedOptionalProperty<MockSupportPackageViewController, UIButton> {
	        return .init(manager: cuckoo_manager, name: "generateSupportPackageButton")
	    }
	    
	    
	    var delegate: Cuckoo.ClassToBeStubbedOptionalProperty<MockSupportPackageViewController, SupportPackageViewControllerDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate")
	    }
	    
	    
	    func back() -> Cuckoo.ClassStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSupportPackageViewController.self, method: "back()", parameterMatchers: matchers))
	    }
	    
	    func generateSupportPackage<M1: Cuckoo.Matchable>(_ sender: M1) -> Cuckoo.ClassStubNoReturnFunction<(Any)> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: sender) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSupportPackageViewController.self, method: "generateSupportPackage(_: Any)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SupportPackageViewController: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var generateSupportPackageButton: Cuckoo.VerifyOptionalProperty<UIButton> {
	        return .init(manager: cuckoo_manager, name: "generateSupportPackageButton", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var delegate: Cuckoo.VerifyOptionalProperty<SupportPackageViewControllerDelegate> {
	        return .init(manager: cuckoo_manager, name: "delegate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func back() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("back()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func generateSupportPackage<M1: Cuckoo.Matchable>(_ sender: M1) -> Cuckoo.__DoNotUse<(Any), Void> where M1.MatchedType == Any {
	        let matchers: [Cuckoo.ParameterMatcher<(Any)>] = [wrap(matchable: sender) { $0 }]
	        return cuckoo_manager.verify("generateSupportPackage(_: Any)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SupportPackageViewControllerStub: SupportPackageViewController {
    
    
     override var generateSupportPackageButton: UIButton! {
        get {
            return DefaultValueRegistry.defaultValue(for: (UIButton?).self)
        }
        
        set { }
        
    }
    
    
     override var delegate: SupportPackageViewControllerDelegate? {
        get {
            return DefaultValueRegistry.defaultValue(for: (SupportPackageViewControllerDelegate?).self)
        }
        
        set { }
        
    }
    

    

    
     override func back()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func generateSupportPackage(_ sender: Any)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: QLog/XcodeLogger.swift at 2019-06-12 18:03:46 +0000

//
//  XcodeLogger.swift
//  QLog
//
//  Created by Christian Oberdörfer on 08.02.18.
//  Copyright © 2018 Quantum. All rights reserved.
//

extension LogLevel {

    /// Associates a emoji with each log level
    var emoji: String {
        switch self {
        case .highlight:
            return "🔮"
        case .debug:
            return "🌀"
        case .info:
            return "📗"
        case .warning:
            return "⚠️"
        case .error:
            return "⛔️"
        }
    }

}

/**
 Logger to log into Xcode console.
 Since Xcode console does not support coloring
 each log message is wrapped into a corresponding pair of emojis.
 */

import Cuckoo
@testable import QLog


public class MockXcodeLogger: XcodeLogger, Cuckoo.ClassMock {
    
    public typealias MocksType = XcodeLogger
    
    public typealias Stubbing = __StubbingProxy_XcodeLogger
    public typealias Verification = __VerificationProxy_XcodeLogger

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: XcodeLogger?

    public func enableDefaultImplementation(_ stub: XcodeLogger) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public override var logLevel: LogLevel {
        get {
            return cuckoo_manager.getter("logLevel",
                superclassCall:
                    
                    super.logLevel
                    ,
                defaultCall: __defaultImplStub!.logLevel)
        }
        
        set {
            cuckoo_manager.setter("logLevel",
                value: newValue,
                superclassCall:
                    
                    super.logLevel = newValue
                    ,
                defaultCall: __defaultImplStub!.logLevel = newValue)
        }
        
    }
    

    

    
    
    
    public override func doLog(_ logEntry: LogEntry)  {
        
    return cuckoo_manager.call("doLog(_: LogEntry)",
            parameters: (logEntry),
            escapingParameters: (logEntry),
            superclassCall:
                
                super.doLog(logEntry)
                ,
            defaultCall: __defaultImplStub!.doLog(logEntry))
        
    }
    

	public struct __StubbingProxy_XcodeLogger: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var logLevel: Cuckoo.ClassToBeStubbedProperty<MockXcodeLogger, LogLevel> {
	        return .init(manager: cuckoo_manager, name: "logLevel")
	    }
	    
	    
	    func doLog<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.ClassStubNoReturnFunction<(LogEntry)> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockXcodeLogger.self, method: "doLog(_: LogEntry)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_XcodeLogger: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var logLevel: Cuckoo.VerifyProperty<LogLevel> {
	        return .init(manager: cuckoo_manager, name: "logLevel", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func doLog<M1: Cuckoo.Matchable>(_ logEntry: M1) -> Cuckoo.__DoNotUse<(LogEntry), Void> where M1.MatchedType == LogEntry {
	        let matchers: [Cuckoo.ParameterMatcher<(LogEntry)>] = [wrap(matchable: logEntry) { $0 }]
	        return cuckoo_manager.verify("doLog(_: LogEntry)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class XcodeLoggerStub: XcodeLogger {
    
    
    public override var logLevel: LogLevel {
        get {
            return DefaultValueRegistry.defaultValue(for: (LogLevel).self)
        }
        
        set { }
        
    }
    

    

    
    public override func doLog(_ logEntry: LogEntry)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

