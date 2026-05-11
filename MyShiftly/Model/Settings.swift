//
//  Settings.swift
//  MyShiftly
//
//  Created by Guriqbal Singh Amroke on 04.05.26.
//

import Foundation
import SwiftData

@Model final class Settings {
    /// Unique identifier ensures only one Settings object exists
    @Attribute(.unique) var id: String

    var name: String

    // Store monetary values as Double for SwiftData compatibility
    // We'll use NumberFormatter for display to avoid floating-point display issues
    var hourlyWage: Double
    var miniJobLimit: Double
    var currency: String

    var workingHoursPerWeek: Double?

    init(
        name: String,
        hourlyWage: Double,
        miniJobLimit: Double = 538.00,
        currency: String = "EUR",
        workingHoursPerWeek: Double? = nil
    ) {
        self.id = "app_settings"
        self.name = name
        self.hourlyWage = hourlyWage
        self.miniJobLimit = miniJobLimit
        self.currency = currency
        self.workingHoursPerWeek = workingHoursPerWeek
    }
}

// MARK: - Computed Properties

extension Settings {
    /// Currency formatter for displaying monetary values with correct locale
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    /// Formats a Double value as a currency string
    func formatCurrency(_ value: Double) -> String {
        currencyFormatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}

// MARK: - Data Loading

extension Settings {
    static func loadOrCreate(in context: ModelContext) -> Settings {
        let descriptor = FetchDescriptor<Settings>()

        if let existing = try? context.fetch(descriptor).first {
            return existing
        }

        let defaultSettings = Settings(
            name: "",
            hourlyWage: 12.41,
            miniJobLimit: 538.00,
            currency: "EUR",
            workingHoursPerWeek: nil
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
