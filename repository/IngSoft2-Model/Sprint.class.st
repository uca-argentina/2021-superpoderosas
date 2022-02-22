Class {
	#name : #Sprint,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Sprint >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame moveForwardAsManyFieldsAsCardsInHandHas: aPlayer.
]

{ #category : #initialization }
Sprint >> initialize [
	reverse:= BackwardSprint.
]

{ #category : #accessing }
Sprint >> reverse [
	^ reverse new.
]
