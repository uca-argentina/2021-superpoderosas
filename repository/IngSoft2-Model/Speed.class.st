Class {
	#name : #Speed,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Speed >> action [
	^ 1.
]

{ #category : #actions }
Speed >> apply: aMove at: aBoardGame [
	self veryfyIf: aMove canBeDoneAt: aBoardGame.
	(aMove playerAffected ) isInfluencedBy: self.
]

{ #category : #actions }
Speed >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	self laysFrom: aMove on: aBoardGame
]
