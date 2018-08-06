//
//  Recipe.swift
//  App
//
//  Created by Andrew R Madsen on 8/5/18.
//

import Foundation

struct Recipe: Codable, Comparable
{
    var name: String
    var instructions: String

	static func <(l:Recipe, r:Recipe) -> Bool
	{
		return l.name < r.name
	}
}
