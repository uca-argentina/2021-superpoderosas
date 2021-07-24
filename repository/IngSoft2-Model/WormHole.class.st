Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard move: aPlayer over: -4.

]
