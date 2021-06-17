Class {
	#name : #OneToAllMove,
	#superclass : #Move,
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
OneToAllMove >> apply: aBlock at: aBoardGame [
	aBoardGame applyToAllPlayers: aBlock.
]

{ #category : #accessing }
OneToAllMove >> currentPlayer [
	^ self subclassResponsibility
]
