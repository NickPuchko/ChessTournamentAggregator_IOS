import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        var ref: DatabaseReference!
        ref = Database.database().reference()

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        //window.rootViewController = UINavigationController(rootViewController: container.viewController)
        let vc = UINavigationController(rootViewController: Auth_ViewController(ref: ref))

        window.rootViewController = vc
        window.makeKeyAndVisible()

        return true
    }
}

