//
//  BifocalCoreDataTests.swift
//  Bifocal
//
//  Created by Henry Lightfoot on 01/10/2025.
//

import XCTest
import CoreData

@testable import Bifocal

final class BifocalCoreDataTests: XCTestCase {

    var coreDataStack: CoreDataStack!

    override func setUpWithError() throws {
        coreDataStack = CoreDataStack()
    }

    override func tearDownWithError() throws {
        coreDataStack = nil
    }

    func testCreateAndSaveSkill() throws {
        let context = coreDataStack.persistentContainer.viewContext

        let newSkill = SkillEntity(context: context)
        newSkill.id = UUID()
        newSkill.title = "Test Mindfulness Skill"
        newSkill.symbol = "brain.head.profile"
        
        coreDataStack.save()

        let fetchRequest: NSFetchRequest<SkillEntity> = SkillEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "title == %@", "Test Mindfulness Skill")

        do {
            let fetchedSkills = try context.fetch(fetchRequest)

            XCTAssertEqual(fetchedSkills.count, 1, "Should find exactly one skill with the test title.")
            XCTAssertEqual(fetchedSkills.first?.symbol, "brain.head.profile", "The fetched skill's symbol should match the saved one.")
            
        } catch {
            XCTFail("Fetching the saved skill failed with error: \(error)")
        }
    }
}
