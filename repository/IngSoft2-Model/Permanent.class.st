Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Permanent >> action [
	^ self subclassResponsibility
]

{ #category : #actions }
Permanent >> apply: aMove at: aBoardGame [
	^ self subclassResponsibility
]

{ #category : #actions }
Permanent >> do: aMove at: aBoardGame [
	^ self subclassResponsibility
]

{ #category : #validations }
Permanent >> veryfyIf: aMove canBeDoneAt: aBoardGame [
	aBoardGame verifyIfItIsTheTurnOf: aMove currentPlayer
]
