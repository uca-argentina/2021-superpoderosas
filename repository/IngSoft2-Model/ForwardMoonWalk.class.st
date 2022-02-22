Class {
	#name : #ForwardMoonWalk,
	#superclass : #Effect,
	#instVars : [
		'reverse',
		'fieldsToAdvance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ForwardMoonWalk class >> with: aNumberOfFildes [ 
	^ self new initializeWith: aNumberOfFildes.
]

{ #category : #actions }
ForwardMoonWalk >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard moveAllPlayers: (fieldsToAdvance) except: aPlayer.
]

{ #category : #initialization }
ForwardMoonWalk >> initializeWith: aNumberOfFildes [ 
	fieldsToAdvance:= aNumberOfFildes .
	reverse := MoonWalk.
]

{ #category : #accessing }
ForwardMoonWalk >> reverse [
	^ reverse with: fieldsToAdvance .
]
