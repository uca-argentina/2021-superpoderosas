Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
MoonWalk >> applyTheEffectOn: aPosition of: aBoardGame [
	| n |
	n := (aPosition field) //2.
	aBoardGame moveAllPlayers: (n negated) exceptThePlayerOf: aPosition.
]
