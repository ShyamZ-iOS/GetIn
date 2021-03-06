

import Foundation
import UIKit



enum Language : String {
    
    case english = "en"
    case french = "fr"
    
}


class  Localizations:NSObject {
    
    var bundle: Bundle!
    
    class var instance: Localizations {
        struct Singleton {
            static let instance: Localizations = Localizations()
            
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        bundle = Bundle.main
    }
    
    func stringForKey(key:String) -> String{
        return bundle.localizedString(forKey: key, value: "", table: nil)
    }
    
    func setLanguage(languageCode:String){
        var appleLangugaes = UserDefaults.standard.object(forKey: UserDefaults.key.appLang) as? [String] ?? [String]()
        if appleLangugaes.count > 0{
            appleLangugaes.remove(at: 0)
            appleLangugaes.insert(languageCode, at: 0)
        }
        UserDefaults.standard.set(appleLangugaes, forKey:  UserDefaults.key.appLang)
        UserDefaults.standard.synchronize() //needs restart
        
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
            bundle = Bundle.init(path: languageDirectoryPath)
        }else{
            resetLocalization()
        }
    }
    
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    func getLanguage() -> String {
        let appleLanguages = UserDefaults.standard.object(forKey:  UserDefaults.key.appLang) as! [String]
        let prefferedLanguage = appleLanguages[0]
        if prefferedLanguage.contains("-"){
            let array = prefferedLanguage.components(separatedBy: "-")
            return array[0]
        }
        return prefferedLanguage
    }
    
}
