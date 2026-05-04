//
//  Settings.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 04.05.26.
//

import Foundation
import SwiftData

@Model final class Settings: PersistentModel {
    @Attribute(.unique) var id: String
    var name: String
    var hourlyWage: Decimal
    var miniJobLimit: Decimal
    var currency: String
    var workingHoursPerWeek: Double?
    var taxRate: Double?
    
    init(
        name: String,
        hourlyWage: Decimal,
        miniJobLimit: Decimal = 538.00,
        currency: String = "EUR",
        workingHoursPerWeek: Double? = nil,
        taxRate: Double? = nil
    ) {
        self.id = "app_settings"
        self.name = name
        self.hourlyWage = hourlyWage
        self.miniJobLimit = miniJobLimit
        self.currency = currency
        self.workingHoursPerWeek = workingHoursPerWeek
        self.taxRate = taxRate
    }
}

extension Settings {
    static func loadOrCreate(in context: ModelContext) -> Settings {
        let descriptor = FetchDescriptor<Settings>()
        
        if let existing = try? context.fetch(descriptor).first {
            return existing
        }
        
        let defaultSettings = Settings(
            name: "",
            hourlyWage: Decimal(12.41),
            miniJobLimit: Decimal(538.00),
            currency: "EUR",
            workingHoursPerWeek: nil,
            taxRate: nil
        )
        
        context.insert(defaultSettings)
        
        do {
            try context.save()
        } catch {
            print("Error saving default settings: \(error)")
        }
        
        return defaultSettings
    }
}
