//
//  Alerts.swift
//  Weather
//
//  Created by Fatih Çimen on 21.12.2018.
//  Copyright © 2018 Fatih Çimen. All rights reserved.
//

import NotificationBannerSwift

public func showStatusBarAlert(title: String, style: BannerStyle = .danger, autoDismiss: Bool = true) {
    
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        let statusBarAlert = StatusBarNotificationBanner(title: title, style: style)
        statusBarAlert.autoDismiss = autoDismiss
        statusBarAlert.show(on: topController)
    }
    
}
