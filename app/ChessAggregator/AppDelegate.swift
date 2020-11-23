import UIKit
import Firebase
import FirebaseDatabase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        self.window = window
//        // TODO: AppCoordinator!
//        let vc = UINavigationController(rootViewController: Auth_ViewController(ref: ref))
//        //let vc = TabBarController(ref: ref, phone: "+7 800 555-35-35")
//        window.rootViewController = vc
//        window.makeKeyAndVisible()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window)
        self.window = window
        self.appCoordinator?.auth()

        return true
    }
}

