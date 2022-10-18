//
//  ProductListApp.swift
//  ProductList
//
//  Created by Phil Martin on 17/10/2022.
//

import SwiftUI

@main
struct ProductListApp: App {

    @StateObject private var dataController = DatabaseManager()

    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
