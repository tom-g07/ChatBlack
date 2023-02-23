//
//  APICaller.swift
//  ChatBlack
//
//  Created by Tom Gutzmann on 15.02.23.
//

import OpenAISwift
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    @frozen enum Constants {
        static let key = "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"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(authToken: Constants.key)
    }
    
    public func getResponse(input: String,
                            completion: @escaping (Result<String, Error>) -> Void ) {
        client?.sendCompletion(with: input, model: .codex(.davinci), completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model.choices))
                let output = model.choices.first?.text  ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
        
    }
    
    
}
