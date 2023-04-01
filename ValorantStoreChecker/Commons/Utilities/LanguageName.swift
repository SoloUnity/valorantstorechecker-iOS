//
//  LanguageName.swift
//  ValorantStoreChecker
//
//  Created by Gordon on 2023-04-01.
//

import Foundation

// Endpoint language names for api calls
func getLanguageName(language: String) -> String {
    switch language {
    case "fr","fr-CA":
        return "fr-FR"
    case "ja":
        return "ja-JP"
    case "ko":
        return "ko-KR"
    case "de":
        return "de-DE"
    case "zh-Hans":
        return "zh-CN"
    case "vi":
        return "vi-VN"
    case "es":
        return "es-ES"
    case "pt-PT", "pt-BR":
        return "pt-BR"
    case "pl":
        return "pl-PL"
    default:
        return "en-US"
    }
}

func getLanguageName(language: String, displayName: String) -> String {
    
    switch language {
    case "fr","fr-CA","de","vi" , "es","pt-PT","pt-BR", "pl":
        let list = displayName.split(separator: " ")
        return String(list[0])
    case "ja":
        return String(Array(displayName)[6...])
    default:
        let list = displayName.split(separator: " ")
        return String(list[1])
    }
    
}

