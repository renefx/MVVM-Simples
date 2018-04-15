//
//  Dog.swift
//  MVVM Simples
//
//  Created by Wesley Brito on 12/03/2018.
//  Copyright © 2018 Curso IOS. All rights reserved.
//

import UIKit
import Bond
import SwiftyJSON

class Dog{
    
    // A classe de modelo necessita de propriedades que sejam Observaveis, através do framework Bond.
    var nickname = Observable<String?>("")
    var legs = Observable<Int?>(4)
    
    // Inicializadores são de suma importância para testes, que podem utilizar de injeção de dependência.
    init(nickname: String) {
        self.nickname.value = nickname
    }
    
    // Este inicializador foi utilizado como exemplo de montagem de objeto através de um JSON, que pode vir através de uma resposta de uma requisição, e facilmente montado.
    init(json: JSON) {
        if let nickname = json["nickname"].string { self.nickname.value = nickname }
        if let legs = json["legs"].int { self.legs.value = legs }
    }
    
    
}


