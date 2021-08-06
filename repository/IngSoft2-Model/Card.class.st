Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Card >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [ 
	^ self subclassResponsibility
]
