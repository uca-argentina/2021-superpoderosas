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
Position >> >= aPosition [ 
	(aPosition round < self round) 
	ifTrue: [ ^ true ]  
	ifFalse: [ (aPosition round > self round) 
								ifTrue: [ ^ false ]
								ifFalse:[(aPosition field < self field) 
															ifTrue:[^ true ]
															ifFalse: [ ^ false ]]].
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

{ #category : #accesing }
Position >> player [
	^ player
]

{ #category : #accesing }
Position >> round [
	^ round
]
