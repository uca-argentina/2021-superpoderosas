Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> with: anN [
	^ self new initializeWith: anN.
]

{ #category : #actions }
MoonWalk >> applyTheEffectOn: aPosition of: aBoardGame [
	aBoardGame moveAllPlayers: (n negated) exceptThePlayerOf: aPosition.
]

{ #category : #initialize }
MoonWalk >> initializeWith: anN [
	n:= anN.
]
