Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'fieldsToMoveBackwars',
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
MoonWalk class >> with: aNumberOfFildes [ 
	^ self new initializeWith: aNumberOfFildes.
]

{ #category : #actions }
MoonWalk >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard moveAllPlayers: (fieldsToMoveBackwars negated) except: aPlayer.

]

{ #category : #initialize }
MoonWalk >> initializeWith: aNumberOfFildes [ 
	fieldsToMoveBackwars := aNumberOfFildes .
	reverse:= ForwardMoonWalk.
]

{ #category : #accessing }
MoonWalk >> reverse [
	^ reverse with: fieldsToMoveBackwars .
]
