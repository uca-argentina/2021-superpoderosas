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
Permanent >> apply: arg1 at: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #actions }
Permanent >> do: arg1 at: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #validations }
Permanent >> veryfyIf: aMove canBeDoneAt: aBoardGame [
	aBoardGame verifyIfItIsTheTurnOf: aMove currentPlayer
]
