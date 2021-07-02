Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'round',
		'field',
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Position class >> of: aPlayer standingOn: aField after: aNumberOfRound [
	^ self new
		initializeOf: aPlayer
		standingOn: aField
		after: aNumberOfRound
]

{ #category : #comparing }
Position >> = aPosition [
	^ ((self round = aPosition round) and: [(self field = aPosition field  )and:[self player = aPosition player]])

]

{ #category : #comparing }
Position >> >= aPosition [
		
	^ ((self round > aPosition round) or: [(self field >= aPosition field  )and:[self round = aPosition round]])
]

{ #category : #accesing }
Position >> field [
	^ field
]

{ #category : #comparing }
Position >> hash [ 
	^ field hash + round hash + player hash.

]

{ #category : #initialize }
Position >> initializeOf: aPlayer standingOn: aField after: aRound [
	round:= aRound.
	field:= aField.
	player:= aPlayer.
]

{ #category : #accesing }
Position >> player [
	^ player
]

{ #category : #accesing }
Position >> round [
	^ round
]
