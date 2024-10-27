//
//  Script+Utils.swift
//  PublishExtras
//
//  Created by Mathew Gacy on 4/28/24.
//  Copyright © 2024 Mobelux. All rights reserved.
//

import Foundation
import Plot

public extension Script {
    /// Returns a script that loads Google Tag Manager.
    ///
    /// - Parameter configuration: The configuration for Google Tag Manager.
    /// - Returns: A script that loads Google Tag Manager.
    static func gtm(_ configuration: GTMConfiguration) -> Self {
        // swiftlint:disable line_length
        .inline("""
            (function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
            new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
            j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
            'https://www.googletagmanager.com/gtm.js?id='+i+dl+ '&gtm_auth=\(configuration.authToken)&gtm_preview=env-\(configuration.previewEnvironment)&gtm_cookies_win=x';f.parentNode.insertBefore(j,f);
            })(window,document,'script','dataLayer','\(configuration.containerID)');
            """)
    }
    // swiftlint:enable line_length
}
