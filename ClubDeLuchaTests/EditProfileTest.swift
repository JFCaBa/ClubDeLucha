//
//  EditProfileTest.swift
//  ClubDeLuchaTests
//
//  Created by Jose on 29/10/2024.
//  Copyright © 2024 Jose Catala. All rights reserved.
//

import XCTest
@testable import ClubDeLucha

@MainActor
final class EditProfileTests: XCTestCase {
    var sut: EditProfileViewModel!
    var mockService: MockProfileService!
    
    override func setUp() {
        super.setUp()
        mockService = MockProfileService()
        sut = EditProfileViewModel(profileService: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testSuccessfulProfileUpdate() async {
        mockService.shouldSucceed = true
        sut.name = "Jane Doe"
        sut.location = "Barcelona"
        sut.weight = "65"
        
        await sut.saveProfile()
        
        XCTAssertNil(sut.error)
        XCTAssertFalse(sut.isLoading)
    }
    
    func testFailedProfileUpdate() async {
        mockService.shouldSucceed = false
        
        await sut.saveProfile()
        
        XCTAssertNotNil(sut.error)
        XCTAssertFalse(sut.isLoading)
    }
}
