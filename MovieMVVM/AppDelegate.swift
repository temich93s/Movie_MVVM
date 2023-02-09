// AppDelegate.swift
// Copyright © SolovevAA. All rights reserved.

import CoreData
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Constants

    private enum Constants {
        static let nameNSPersistentContainerText = "MovieMVVM"
        static let unresolvedErrorText = "Unresolved error"
        static let defaultConfigurationText = "Default Configuration"
    }

    // MARK: - Public Properties

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.nameNSPersistentContainerText)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("\(Constants.unresolvedErrorText) \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Public Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        true
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        UISceneConfiguration(name: Constants.defaultConfigurationText, sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessionsSet: Set<UISceneSession>) {}

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("\(Constants.unresolvedErrorText) \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
