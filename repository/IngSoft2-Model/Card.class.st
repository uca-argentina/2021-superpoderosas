Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Card >> canBePlayedInAnyTurn [
	self subclassResponsibility.
]