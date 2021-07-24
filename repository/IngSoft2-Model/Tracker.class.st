Class {
	#name : #Tracker,
	#superclass : #Object,
	#instVars : [
		'round',
		'field',
		'player',
		'status'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Tracker class >> of: aPlayer standingOn: aField after: aNumberOfRound [
	^ self new
		initializeOf: aPlayer
		standingOn: aField
		after: aNumberOfRound
		definedBy: ActiveCondition new.
]

{ #category : #initialization }
Tracker class >> of: aPlayer standingOn: aField after: aNumberOfRound definedBy: aStatus [
	^ self new
		initializeOf: aPlayer
		standingOn: aField
		after: aNumberOfRound
		definedBy: aStatus.
]

{ #category : #comparing }
Tracker >> = anotherTracker [
	^ ((self round = anotherTracker round) and: [(self field = anotherTracker field  )and:[self player = anotherTracker player]])

]

{ #category : #comparing }
Tracker >> >= anotherTracker [		
	^ ((self round > anotherTracker round) or: [(self field >= anotherTracker field  )and:[self round = anotherTracker round]])
]

{ #category : #accessing }
Tracker >> field [
	^ field
]

{ #category : #actions }
Tracker >> findFieldAfterIntentionToMove: fields [
	^ status findNewValueWhenYouTryAdding: fields with: field.
]

{ #category : #comparing }
Tracker >> hash [ 
	^ field hash + round hash + player hash.

]

{ #category : #initialize }
Tracker >> initializeOf: aPlayer standingOn: aField after: aRound definedBy: aStatus [
	round:= aRound.
	field:= aField.
	player:= aPlayer.
	status:= aStatus.
]

{ #category : #actions }
Tracker >> isBlocked [
	^status isBlocked.
]

{ #category : #accessing }
Tracker >> player [
	^ player
]

{ #category : #actions }
Tracker >> resetFieldNumber [
	^status resetValueWhenActualIs: field.
]

{ #category : #accessing }
Tracker >> round [
	^ round
]

{ #category : #accessing }
Tracker >> status [
	^ status
]
