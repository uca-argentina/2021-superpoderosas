Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#instVars : [
		'effect'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
SpeedUp >> effectTriggeredBy: aPlayer on: aBoard of: aBoardGame [
	aBoard move: aPlayer over: 4 on: aBoardGame.

]
