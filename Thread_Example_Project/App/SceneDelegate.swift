//
//  SceneDelegate.swift
//  Thread_Example_Project
//
//  Created by 김우성 on 2021/07/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var boolValue = 0

    // TODO: 1. 이미지뷰 생성
        var imageView: UIImageView?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

//            
//            self.boolValue += 1
//            
//            if boolValue > 1 {
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
//                    self.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//                    let Alert = UIAlertController(
//                        title: "",
//                        message: "계속 하시겠습니까?",
//                        preferredStyle: UIAlertController.Style.alert
//                    )
//                    let AllowAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
//                    Alert.addAction(AllowAction)
//                    self.window?.rootViewController?.present(Alert, animated: true, completion: nil)
//                }
//            }
            
            // TODO: 3. 앱이 다시 활성화 상태가 되면 이미지뷰를 superview (window)에서 제거한다
            if let imageView = imageView {
                imageView.removeFromSuperview()
            }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // TODO: 2. will resign active 상태가 호출되면 imageview를 window 크기로 잡아주고 window에 추가한다
        guard let window = window else {
            return
        }
        imageView = UIImageView(frame: window.frame)
        imageView?.image = UIImage(named: "스크린샷 2022-08-01 15.50.33.png" )
        window.addSubview(imageView!)
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

