Class {
	#name : #Move,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Move >> apply: arg1 at: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
Move >> currentPlayer [
	^ self subclassResponsibility
]
