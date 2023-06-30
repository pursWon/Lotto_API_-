import UIKit

class ThemeProvider {
    static let shared = ThemeProvider()
    
    var theme: Theme {
        didSet {
            UserDefaults.standard.set(theme == .light, forKey: "isDark")
            notifyObservers()
        }
    }
    
    private var observers: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    private init() {
        self.theme = UserDefaults.standard.bool(forKey: "isDark") ? .dark : .light
    }

    func toggleTheme() {
        theme = theme == .light ? .dark : .light
    }

    func register<Observer: Themeable>(observer: Observer) {
        observer.apply(theme: theme)
        
        self.observers.add(observer)
    }

    private func notifyObservers() {
        DispatchQueue.main.async {
            self.observers.allObjects
                .compactMap({ $0 as? Themeable })
                .forEach({ $0.apply(theme: self.theme) })
        }
    }
}
