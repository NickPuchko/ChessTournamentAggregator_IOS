import UIKit
import Firebase
import FirebaseDatabase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.appCoordinator = AppCoordinator(window: window)
        self.window = window
        self.appCoordinator?.auth()
        Auth.auth().addStateDidChangeListener{(auth, user) in
            if user == nil{
                self.showModalAuth()
            }
        }
        return true
    }
    func showModalAuth(){
//        let storyboard = UIStoryboard
//        let newVC = storyboard.instantiateViewController(withIdentifier: "AuthViewControllerc") as! AuthViewController
//        self.window?.rootViewController?.present(newVC, animated: true, completion: nil)
    }


}

