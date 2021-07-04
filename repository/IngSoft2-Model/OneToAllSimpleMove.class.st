Class {
	#name : #OneToAllSimpleMove,
	#superclass : #OneToAllMove,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToAllSimpleMove class >> madeBy: currentPlayer [ 
	^ self new initializeMadeBy: currentPlayer.
]

{ #category : #accessing }
OneToAllSimpleMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
OneToAllSimpleMove >> initializeMadeBy: aCurrentPlayer [
	currentPlayer := aCurrentPlayer.
]
