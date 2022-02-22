Class {
	#name : #CardRemover,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardRemover >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame takeAwayACardFrom: aPlayer.
]

{ #category : #initialization }
CardRemover >> initialize [
	reverse:= CardDealer.
]

{ #category : #accessing }
CardRemover >> reverse [
	^ reverse new.
]
