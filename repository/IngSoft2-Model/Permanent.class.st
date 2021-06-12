Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Permanent >> canBePlayedInAnyTurn [
	^false.
]

{ #category : #actions }
Permanent >> canBePlayedInAnyTurnAt: aBoardGame [
	^false.
]
