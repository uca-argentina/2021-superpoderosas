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
MoonWalk >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard moveAllPlayers: (fieldsToMoveBackwars negated)  except: aPlayer.

]

{ #category : #initialize }
MoonWalk >> initializeWith: fields [ 
	fieldsToMoveBackwars:=fields.
]
