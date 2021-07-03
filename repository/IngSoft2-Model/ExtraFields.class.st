Class {
	#name : #ExtraFields,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
ExtraFields >> apply: aMove at: aBoardGame [
	self veryfyIf: aMove canBeDoneAt: aBoardGame.
	(aMove playerAffected ) isInfluencedBy: self.
]

{ #category : #'as yet unclassified' }
ExtraFields >> applyToAllPlayers: aMove at: aBoardGame [
	self veryfyIf: aMove canBeDoneAt: aBoardGame.
	aBoardGame applyToAllPlayers: [ :player | player isInfluencedBy: self ].
]

{ #category : #'as yet unclassified' }
ExtraFields >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	self laysFrom: aMove on: aBoardGame
]

{ #category : #'as yet unclassified' }
ExtraFields >> extraFieldAction [
	^ 1.
]

{ #category : #'as yet unclassified' }
ExtraFields >> overloadAction [
	^ -2.
]
