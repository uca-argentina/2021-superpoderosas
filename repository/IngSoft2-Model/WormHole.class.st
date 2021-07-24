Class {
	#name : #WormHole,
	#superclass : #Effect,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
WormHole >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard move: aPlayer over: -4 on: aBoardGame.

]
