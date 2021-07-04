Class {
	#name : #Move,
	#superclass : #Object,
	#instVars : [
		'currentPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Move >> apply: aBlock at: aBoardGame [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
Move >> currentPlayer [
	^ self subclassResponsibility
]
