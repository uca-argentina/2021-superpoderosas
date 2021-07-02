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
MoonWalk >> applyTheEffectOn: aPosition of: aBoard [
	aBoard moveAllPlayers: (fieldsToMoveBackwars negated) exceptThePlayerOf: aPosition.
	super.
]

{ #category : #actions }
MoonWalk >> applyTheEffectOn: newPosition of: aBoard usedAt: aBoardGame [
	aBoard moveAllPlayers: (fieldsToMoveBackwars negated) exceptThePlayerOf: newPosition.
	super.
]

{ #category : #initialize }
MoonWalk >> initializeWith: aNumberOfFildes [ 
	fieldsToMoveBackwars := aNumberOfFildes .
]
