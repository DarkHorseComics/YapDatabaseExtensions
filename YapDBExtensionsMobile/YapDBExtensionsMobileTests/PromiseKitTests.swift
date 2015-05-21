//
//  PromiseKitTests.swift
//  YapDBExtensionsMobile
//
//  Created by Daniel Thorpe on 15/04/2015.
//  Copyright (c) 2015 Daniel Thorpe. All rights reserved.
//

import Foundation
import XCTest
import PromiseKit
import YapDatabase
import YapDatabaseExtensions
import YapDBExtensionsMobile

extension AsynchronousWriteTests {

    func test_ReadingAndWriting_Object_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of object.")

        (db.asyncWrite(person) as PromiseKit.Promise<Person>).then { saved -> Void in
            validateWrite(saved, self.person, usingDatabase: db)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_ReadingAndWriting_Value_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of value.")

        (db.asyncWrite(barcode) as PromiseKit.Promise<Barcode>).then { saved -> Void in
            validateWrite(saved, self.barcode, usingDatabase: db)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_ReadingAndWriting_ValueWithValueMetadata_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of value with value metadata.")

        (db.asyncWrite(product) as PromiseKit.Promise<Product>).then { saved -> Void in
            validateWrite(saved, self.product, usingDatabase: db)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}

extension AsynchronousReadTests {

    func test_Reading_Value_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async reading of value by key.")

        db.write(barcode)
        db.asyncRead(keyForPersistable(barcode)).then { (read: Barcode?) -> Void in
            XCTAssertTrue(read != nil, "There should be an object in the database.")
            XCTAssertEqual(read!, self.barcode, "The value returned from a save value function should equal the argument.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_Reading_Object_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async reading of value by key.")

        db.write(person)
        db.asyncRead(keyForPersistable(person)).then { (read: Person?) -> Void in
            XCTAssertTrue(read != nil, "There should be an object in the database.")
            XCTAssertEqual(read!, self.person, "The value returned from a save value function should equal the argument.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_Reading_Values_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async reading of value by key.")

        let values = barcodes()
        db.write(values)

        db.asyncRead(map(values, keyForPersistable)).then { (read: [Barcode]) -> Void in
            XCTAssertEqual(values, Set(read), "Expecting all keys in collection to return all items.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_Reading_Objects_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async reading of object by key.")

        let objects = people()
        db.write(objects)

        db.asyncRead(map(objects, keyForPersistable)).then { (read: [Person]) -> Void in
            XCTAssertEqual(objects, read, "Expecting all keys in collection to return all items.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}

extension AsynchronousRemoveTests {

    func test_RemovePersistable_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of object.")

        db.write(barcode)
        XCTAssertEqual((db.readAll() as [Barcode]).count, 1, "There should be one barcodes in the database.")

        (db.asyncRemove(barcode) as PromiseKit.Promise<Void>).then { () -> Void in
            XCTAssertEqual((db.readAll() as [Barcode]).count, 0, "There should be no barcodes in the database.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_RemovePersistables_PromiseKit() {
        let db = YapDB.testDatabaseForFile(__FILE__, test: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of object.")

        let _people = people()
        db.write(_people)
        XCTAssertEqual((db.readAll() as [Person]).count, _people.count, "There should be \(_people.count) Person in the database.")

        (db.asyncRemove(_people) as PromiseKit.Promise<Void>).then { () -> Void in
            XCTAssertEqual((db.readAll() as [Person]).count, 0, "There should be no Person in the database.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}
