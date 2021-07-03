Class {
	#name : #Overload,
	#superclass : #Permanent,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Overload >> action [
	^ -2.
]

{ #category : #actions }
Overload >> apply: aMove at: aBoardGame [
	self veryfyIf: aMove canBeDoneAt: aBoardGame.
	aBoardGame affect: (aMove playerAffected) with: self.
]

{ #category : #actions }
Overload >> do: aMove at: aBoardGame [
	self apply: aMove at: aBoardGame.
	self laysFrom: aMove on: aBoardGame
]
