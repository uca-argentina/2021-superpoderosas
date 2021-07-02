Class {
	#name : #Acceleration,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Acceleration >> action [
	^ 1.
]

{ #category : #actions }
Acceleration >> apply: aMove at: aBoardGame [
	self veryfyIf: aMove canBeDoneAt: aBoardGame.
	aBoardGame applyToAllPlayers: [ :player | player isInfluencedBy: self ].
]

{ #category : #actions }
Acceleration >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	self laysFrom: aMove on: aBoardGame
]
