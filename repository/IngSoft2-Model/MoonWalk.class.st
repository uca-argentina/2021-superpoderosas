Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'fieldsToMoveBackwars'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> with: aNumberOfFildes [ 
	^ self new initializeWith: aNumberOfFildes.
]

{ #category : #actions }
MoonWalk >> applyTheEffectOn: aPosition of: aBoardGame [
	aBoardGame moveAllPlayers: (fieldsToMoveBackwars negated) exceptThePlayerOf: aPosition.
	super.
]

{ #category : #initialize }
MoonWalk >> initializeWith: aNumberOfFildes [ 
	fieldsToMoveBackwars := aNumberOfFildes .
]
