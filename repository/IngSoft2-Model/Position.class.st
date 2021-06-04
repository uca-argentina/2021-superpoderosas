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
	((self round = aPosition round) & (self field = aPosition field ) & (self player = aPosition player))
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #comparing }
Position >> >= aPosition [
	aPosition round < self round
		ifTrue: [ ^ true ]
		ifFalse: [ ^(self isTheRoundSmallerThanRoundIn: aPosition) ]
]

{ #category : #accesing }
Position >> description [
	^ player, ', round: ', round asString, ' field: ', field asString.
]

{ #category : #accesing }
Position >> field [
	^ field
]

{ #category : #initialize }
Position >> initializeOf: aPlayer standingOn: aField after: aRound [
	round:= aRound.
	field:= aField.
	player:= aPlayer.
]

{ #category : #private }
Position >> isFieldGreaterThanFieldIn: aPosition [
	(aPosition field < self field)
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ]
]

{ #category : #private }
Position >> isTheRoundSmallerThanRoundIn: aPosition [
	(aPosition round > self round)
		ifTrue: [ ^ false ]
		ifFalse: [^(self isFieldGreaterThanFieldIn: aPosition) ]
]

{ #category : #accesing }
Position >> player [
	^ player
]

{ #category : #accesing }
Position >> round [
	^ round
]
