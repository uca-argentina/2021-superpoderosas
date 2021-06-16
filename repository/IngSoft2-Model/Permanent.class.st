Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Permanent >> veryfyIf: aMove canBeDoneAt: aBoardGame [
	aBoardGame verifyIfItIsTheTurnOf: aMove currentPlayer
]
