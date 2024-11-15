//
//  AuthService.swift
//  Poemify
//
//  Created by Artem Doloban on 15.11.2024.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() {}

    func updatePassword(currentPassword: String, newPassword: String, completion: @escaping (Result<String, Error>) -> Void) {
        let credential = EmailAuthProvider.credential(withEmail: Auth.auth().currentUser?.email ?? "", password: currentPassword)
        
        Auth.auth().currentUser?.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success("Password updated successfully."))
                    }
                }
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let signOutError as NSError {
            completion(.failure(signOutError))
        }
    }
}
