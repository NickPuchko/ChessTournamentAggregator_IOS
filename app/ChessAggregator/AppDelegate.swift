import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window)
        self.window = window
        Auth.auth().addStateDidChangeListener{ [weak self] (auth, user) in
            if Auth.auth().currentUser != nil {
                self?.appCoordinator?.startApp()
            } else {
                self?.appCoordinator?.auth()
            }
        }
        return true
    }
}

