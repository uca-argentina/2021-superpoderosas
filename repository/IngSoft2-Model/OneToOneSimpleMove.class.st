Class {
	#name : #OneToOneSimpleMove,
	#superclass : #OneToOneMove,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToOneSimpleMove class >> madeBy: currentPlayer affecting: player [ 
	^ self new madeBy: currentPlayer affecting: player.
]

{ #category : #accessing }
OneToOneSimpleMove >> currentPlayer [
	^ currentPlayer
]

{ #category : #initialize }
OneToOneSimpleMove >> madeBy: aCurrentPlayer affecting: aPlayer [ 
	playerAffected:= aPlayer.
	currentPlayer := aCurrentPlayer.
	
]

{ #category : #accessing }
OneToOneSimpleMove >> playerAffected [
	^ playerAffected
]
