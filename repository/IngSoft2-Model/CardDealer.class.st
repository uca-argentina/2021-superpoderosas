Class {
	#name : #CardDealer,
	#superclass : #Effect,
	#instVars : [
		'reverse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
CardDealer >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoardGame dealACardTo: aPlayer.
]

{ #category : #initialization }
CardDealer >> initialize [
	reverse:= CardRemover.
]

{ #category : #accessing }
CardDealer >> reverse [
	^ reverse new.
]
