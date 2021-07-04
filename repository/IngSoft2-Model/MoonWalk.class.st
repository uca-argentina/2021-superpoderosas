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
MoonWalk >> effectTriggeredBy: player on: aBoard [
	aBoard moveAllPlayers: (fieldsToMoveBackwars negated) except: player.
	super.
]

{ #category : #actions }
MoonWalk >> effectTriggeredBy: player on: aBoard of: aBoardGame [
	aBoard moveAllPlayers: (fieldsToMoveBackwars negated) except: player.
	super.
]

{ #category : #initialize }
MoonWalk >> initializeWith: aNumberOfFildes [ 
	fieldsToMoveBackwars := aNumberOfFildes .
]
