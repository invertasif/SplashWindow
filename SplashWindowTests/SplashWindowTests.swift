//
//  SplashWindowTests.swift
//  SplashWindowTests
//
//  Created by Hao Zheng on 4/29/17.
//  Copyright © 2017 Hao Zheng. All rights reserved.
//

import XCTest
@testable import SplashWindow

class SplashWindowTests: XCTestCase {
    
    func testInitializers() {
        let protectedWindow = UIWindow()
        var splash = SplashWindow.init(window: protectedWindow, launchViewController: UIViewController())
        XCTAssertNotNil(splash.rootViewController)
        
        splash = SplashWindow.init(window: protectedWindow, launchXibView: UIView())
        XCTAssertNotNil(splash.rootViewController)
    }
    
    func testIsAuthenticating() {

        let protectedWindow = UIWindow()
        let splash = SplashWindow.init(window: protectedWindow, launchViewController: UIViewController())
        
        //using fake appAuth
        let fakeAppAuth = FakeAppAuthentication()
        fakeAppAuth.fakeTouchIDEnabledOnDevice = true //assume device support touchID
        
        //inject
        splash.appAuth = fakeAppAuth
        XCTAssertFalse(splash.isAuthenticating)
        
        //turn on touchID
        splash.appAuth.setTouchID(enabled: true)
        splash.authenticateUser(isLoggedIn: true)
        XCTAssertTrue(splash.isAuthenticating)
    }
}

