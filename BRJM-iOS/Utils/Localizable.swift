import Foundation
import UIKit


/**
 - Note: 다국어 처리
 */

let MPSCurrentLanguageKey = "LCurrentLanguageKey"
let MPSDefaultLanguage = "en-US"
let MPSBaseBundle = "Base"
let MPSCurrentTableNameKey = "LCurrentTableNameKey"
let MPSDefaultTableName = "Localizable"

public let MPSLanguageChangeNotification = "LLanguageChangeNotification"


public protocol LanguageDelegate: AnyObject {
    func language(_ language: Localizable.Type, getLanguageFlag flag: UIImage)
}

public extension String {
    
    func localized() -> String {
        return localized(using: Localizable.getTableName())
    }
    
    func localized(using tableName: String, in bundle: Bundle = .main) -> String {
        if let path = bundle.path(forResource: Localizable.getCurrentLanguage(), ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        else if let path = bundle.path(forResource: MPSBaseBundle, ofType: "lproj"),
            let bundle = Bundle(path: path) {
            return bundle.localizedString(forKey: self, value: nil, table: tableName)
        }
        return self
    }
}

public class Localizable : NSObject {
    
    public static var delegate : LanguageDelegate?

    public class func getTableName() -> String {
        if let currentTableName = UserDefaults.standard.object(forKey: MPSCurrentTableNameKey) as? String {
            return currentTableName
        }
        return MPSDefaultTableName
    }

    public class func setTableName(_ name: String) {
        UserDefaults.standard.set(name, forKey: MPSCurrentTableNameKey)
        UserDefaults.standard.synchronize()
    }


    
    public class func getAllLanguages(_ bundle: Bundle = .main) -> [String] {
        var listLanguages = bundle.localizations
        
        if let indexOfBase = listLanguages.index(of: MPSBaseBundle) {
            listLanguages.remove(at: indexOfBase)
        }
        
        return listLanguages
    }
    
    public class func getCurrentLanguage() -> String {
        if let currentLanguage = UserDefaults.standard.object(forKey: MPSCurrentLanguageKey) as? String {
            return currentLanguage
        }
        return getDefaultLanguage()
    }
    
    public class func setCurrentLanguage(_ language: String, bundle: Bundle = .main) {
        let selectedLanguage = getAllLanguages(bundle).contains(language) ? language : getDefaultLanguage()
        if (selectedLanguage != getCurrentLanguage()){
            UserDefaults.standard.set(selectedLanguage, forKey: MPSCurrentLanguageKey)
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: Notification.Name(rawValue: MPSLanguageChangeNotification), object: nil)
        }
    }
    
    public class func getDefaultLanguage(bundle: Bundle = .main) -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = bundle.preferredLocalizations.first else {
            return MPSDefaultLanguage
        }
        let availableLanguages: [String] = getAllLanguages(bundle)
        if (availableLanguages.contains(preferredLanguage)) {
            defaultLanguage = preferredLanguage
        }
        else {
            defaultLanguage = MPSDefaultLanguage
        }
        return defaultLanguage
    }
    
    public class func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.getDefaultLanguage())
    }
    
    public class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: getCurrentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}

extension Localizable {
    
    class func getDataFromUrl(url : URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) {
            data, response, error in completion(data, response, error)
            }.resume()
    }
    
    class func downloadImage(url: URL,  completionHandler: @escaping (UIImage?) -> Void) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                let image = UIImage(data: data)
                completionHandler(image)
            }
        }
    }
    
}
