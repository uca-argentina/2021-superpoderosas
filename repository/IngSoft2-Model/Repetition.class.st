Class {
	#name : #Repetition,
	#superclass : #Instantaneous,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Repetition >> apply: aMove at: aBoardGame [
	aMove apply: [ :player | aBoardGame repeatLastEffectAppliedOn: player ] at: aBoardGame.
]

{ #category : #actions }
Repetition >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	self laysFrom: aMove on: aBoardGame.
]
