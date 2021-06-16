Class {
	#name : #OneToAllMove,
	#superclass : #Move,
	#instVars : [
		'currentPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToAllMove >> apply: aBlock at: aBoardGame [
	aBoardGame applyToAllPlayers: aBlock.
]

{ #category : #accessing }
OneToAllMove >> currentPlayer [
	^ self subclassResponsibility
]
