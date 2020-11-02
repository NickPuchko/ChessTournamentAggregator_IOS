import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //FirebaseApp.configure()

        let window = UIWindow()
        let navigationBar = UINavigationController(rootViewController: AuthVC())
        //navigationBar.navigationBar.backgroundColor = .lightGray
        
        window.rootViewController = navigationBar
        
        self.window = window
        return true
    }
}

