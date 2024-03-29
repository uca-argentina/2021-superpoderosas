Class {
	#name : #Tracker,
	#superclass : #Object,
	#instVars : [
		'round',
		'field',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Tracker class >> of: aPlayer standingOn: aField after: aNumberOfRound [
	^ self new
		initializeOf: aPlayer
		standingOn: aField
		after: aNumberOfRound
]

{ #category : #comparing }
Tracker >> = anotherTracker [
	^ ((self round = anotherTracker round) and: [(self field = anotherTracker field  )and:[self player = anotherTracker player]])

]

{ #category : #comparing }
Tracker >> >= anotherTracker [		
	^ ((self round > anotherTracker round) or: [(self field >= anotherTracker field  )and:[self round = anotherTracker round]])
]

{ #category : #accesing }
Tracker >> field [
	^ field
]

{ #category : #comparing }
Tracker >> hash [ 
	^ field hash + round hash + player hash.

]

{ #category : #initialize }
Tracker >> initializeOf: aPlayer standingOn: aField after: aRound [
	round:= aRound.
	field:= aField.
	player:= aPlayer.
]

{ #category : #accesing }
Tracker >> player [
	^ player
]

{ #category : #accesing }
Tracker >> round [
	^ round
]
