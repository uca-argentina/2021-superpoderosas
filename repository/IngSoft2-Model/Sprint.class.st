Class {
	#name : #Sprint,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Sprint >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame moveAsManyFieldsAsCardsInHandHas: aPlayer.
]
