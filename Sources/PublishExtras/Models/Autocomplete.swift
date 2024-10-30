//
//  Autocomplete.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/24/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation

/// The value for an input element's `autocomplete` attribute.
public struct Autocomplete: Equatable, Sendable {
    /// The autocomplete attribute value.
    public let value: String

    /// Creates an instance with the given value.
    ///
    /// - Parameter value: The expected type of value.
    public init(_ value: String) {
        self.value = value
    }
}

public extension Autocomplete {
    /// Default. Autocomplete is on (enabled).
    static let on = Self("on")
    // swiftlint:disable:previous identifier_name

    /// Autocomplete is off (disabled).
    static let off = Self("off")

    /// Expects the first line of the street address.
    static let addressLine1 = Self("address-line1")

    /// Expects the second line of the street address.
    static let addressLine2 = Self("address-line2")

    /// Expects the third line of the street address.
    static let addressLine3 = Self("address-line3")

    /// Expects the first level of the address, e.g. the county.
    static let addressLevel1 = Self("address-level1")

    /// Expects the second level of the address, e.g. the city.
    static let addressLevel2 = Self("address-level2")

    /// Expects the third level of the address.
    static let addressLevel3 = Self("address-level3")

    /// Expects the fourth level of the address.
    static let addressLevel4 = Self("address-level4")

    /// Expects the full street address.
    static let streetAddress = Self("street-address")

    /// Expects the country code.
    static let country = Self("country")

    /// Expects the country name.
    static let countryName = Self("country-name")

    /// Expects the post code.
    static let postalCode = Self("postal-code")

    /// Expects the full name.
    static let name = Self("name")

    /// Expects the middle name.
    static let additionalName = Self("additional-name")

    /// Expects the last name.
    static let familyName = Self("family-name")

    /// Expects the first name.
    static let givenName = Self("given-name")

    /// Expects the title, like "Mr", "Ms" etc.
    static let honorificPrefix = Self("honorific-prefix")

    /// Expects the suffix, like "5", "Jr." etc.
    static let honorificSuffix = Self("honorific-suffix")

    /// Expects the nickname.
    static let nickname = Self("nickname")

    /// Expects the job title.
    static let organizationTitle = Self("organization-title")

    /// Expects the username.
    static let username = Self("username")

    /// Expects a new password.
    static let newPassword = Self("new-password")

    /// Expects the current password.
    static let currentPassword = Self("current-password")

    /// Expects the full birthday date.
    static let bday = Self("bday")

    /// Expects the day of the birthday date.
    static let bdayDay = Self("bday-day")

    /// Expects the month of the birthday date.
    static let bdayMonth = Self("bday-month")

    /// Expects the year of the birthday date.
    static let bdayYear = Self("bday-year")

    /// Expects the gender.
    static let sex = Self("sex")

    /// Expects a one time code for verification etc.
    static let oneTimeCode = Self("one-time-code")

    /// Expects the company name.
    static let organization = Self("organization")

    /// Expects the credit card owner's full name.
    static let ccName = Self("cc-name")

    /// Expects the credit card owner's first name.
    static let ccGivenName = Self("cc-given-name")

    /// Expects the credit card owner's middle name.
    static let ccAdditionalName = Self("cc-additional-name")

    /// Expects the credit card owner's full name.
    static let ccFamilyName = Self("cc-family-name")

    /// Expects the credit card's number.
    static let ccNumber = Self("cc-number")

    /// Expects the credit card's expiration date.
    static let ccExp = Self("cc-exp")

    /// Expects the credit card's expiration month.
    static let ccExpMonth = Self("cc-exp-month")

    /// Expects the credit card's expiration year.
    static let ccExpYear = Self("cc-exp-year")

    /// Expects the CVC code.
    static let ccCsc = Self("cc-csc")

    /// Expects the credit card's type of payment.
    static let ccType = Self("cc-type")

    /// Expects the currency.
    static let transactionCurrency = Self("transaction-currency")

    /// Expects a number, the amount.
    static let transactionAmount = Self("transaction-amount")

    /// Expects the preferred language.
    static let language = Self("language")

    /// Expects a web address.
    static let url = Self("url")

    /// Expects the email address.
    static let email = Self("email")

    /// Expects an image.
    static let photo = Self("photo")

    /// Expects the full phone number.
    static let tel = Self("tel")

    /// Expects the country code of the phone number.
    static let telCountryCode = Self("tel-country-code")

    /// Expects the phone number with no country code.
    static let telNational = Self("tel-national")

    /// Expects the area code of the phone number.
    static let telAreaCode = Self("tel-area-code")

    /// Expects the phone number with no country code and no area code.
    static let telLocal = Self("tel-local")

    /// Expects the local prefix of the phone number.
    static let telLocalPrefix = Self("tel-local-prefix")

    /// Expects the local suffix of the phone number.
    static let telLocalSuffix = Self("tel-local-suffix")

    /// Expects the extension code of the phone number.
    static let telExtension = Self("tel-extension")

    /// Expects the URL of an instant messaging protocol endpoint.
    static let impp = Self("impp")
}
