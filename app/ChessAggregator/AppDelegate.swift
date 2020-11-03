import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //FirebaseApp.configure()

        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: AuthVC())
        
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }
}

