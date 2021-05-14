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
Position class >> determinedMainlyBy: aRound andSecondlyBy: aField has: aPlayer [
	^ self new initializeDeterminedMainlyBy: aRound andSecondlyBy: aField has: aPlayer.
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
Position >> initializeDeterminedMainlyBy: aRound andSecondlyBy: aField has: aPlayer [
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
