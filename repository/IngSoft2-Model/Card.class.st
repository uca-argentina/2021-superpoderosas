Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> notifyCancellationRegarding: target on: aBoardGame [
	self subclassResponsibility.
]

{ #category : #accessing }
Card >> thrownBy: aPlayer aims: aTarget on: aBoardGame handledBy: cardHandler [
	^ self subclassResponsibility
]
