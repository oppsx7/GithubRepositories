//
//  Extensions.swift
//  GitHubRepositories
//
//  Created by Todor Dimitrov on 23.05.22.
//

import Foundation
import UIKit

typealias DateTime = Int64

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension DateTime {
    func convertFromUnixToDateTime (format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval((self) / 1000))
        let df = DateFormatter()
        df.dateFormat = format
        let strDate = df.string(from: date)
        
        return strDate
    }
    
    func toHumanReadable() -> String {
        let interval = TimeInterval(self/1000)
        let calendar = Calendar.current
        let date = Date(timeIntervalSince1970: interval)
        let now = Date()
        let earliest = date < now ? date : now
        let latest =  date > now ? date : now
        
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfMonth, .month, .year, .second]
        let components: DateComponents = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        let hours = components.hour
        
        let df = DateFormatter()
        df.dateFormat = "h:mm:ss"
        
        if let year = components.year {
            if (year >= 2) {
                return String(format: "%d years ago", year)
            } else if (year >= 1) {
                return "one year ago"
            }
        }
        if let month = components.month {
            if (month >= 2) {
                return String(format: "%d months ago", month)
            } else if (month >= 1) {
                return "one month ago"
            }
        }
        if let weekOfMonth = components.weekOfMonth {
            if (weekOfMonth >= 2) {
                return String(format: "%d weeks ago", weekOfMonth)
            } else if (weekOfMonth >= 1) {
                return "one week ago"
            }
        }
        
        
        
        if var day = components.day {
            if (hours! - (calendar.component(.hour, from: Date())) > 0) {
                day += 1
            }
            
            if (day >= 2) {
                return String(format: "%d days ago", day)
            } else if (day == 1) {
                return "yesterday, \(df.string(from: date))"
            }
        }
        
        if let hour = components.hour {
            if (hour >= 2) {
                return String(format: "%d hours ago", hour)
            } else if (hour >= 1) {
                return "one hour ago"
            }
        }
        
        if let minute = components.minute {
            if (minute >= 2) {
                return String(format: "%d minutes ago", minute)
            } else if (minute >= 1) {
                return "one minute ago"
            }
        }
        if let second = components.second {
            if (second >= 3) {
                return String(format: "%d seconds ago", second)
            }
        }
        return "just now"
    }
    
}

func dateFromWebtoApp(_ dateString: String) -> DateTime {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = dateFormatter.date(from: dateString)
    return DateTime(date!.timeIntervalSince1970)
}
