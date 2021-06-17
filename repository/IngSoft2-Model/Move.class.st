Class {
	#name : #Move,
	#superclass : #Object,
	#instVars : [
		'currentPlayer'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Move >> apply: arg1 at: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
Move >> currentPlayer [
	^ self subclassResponsibility
]
