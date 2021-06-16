Class {
	#name : #SimpleMove,
	#superclass : #Object,
	#instVars : [
		'currentPlayer',
		'playersAffected'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #inicialization }
SimpleMove class >> madeBy: currentPlayer affecting: player [ 
	^ self new madeBy: currentPlayer affecting: player.
]

{ #category : #accessing }
SimpleMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
SimpleMove >> madeBy: aCurrentPlayer affecting: aPlayer [ 
	playersAffected:= aPlayer.
	currentPlayer := aCurrentPlayer.
	
]

{ #category : #accessing }
SimpleMove >> playersAffected [
	^ playersAffected
]
