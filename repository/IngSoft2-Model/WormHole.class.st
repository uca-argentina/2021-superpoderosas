Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> effectTriggeredBy: aPosition on: aBoard [
	aBoard move: aPosition over: -4.
	super
]

{ #category : #actions }
WormHole >> effectTriggeredBy: newPosition on: aBoard of: aBoardGame [
	aBoard move: newPosition over: -4.
	super
]
