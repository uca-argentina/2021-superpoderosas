Class {
	#name : #OneToAllMove,
	#superclass : #Move,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
OneToAllMove >> apply: aBlock at: aBoardGame [
	aBoardGame applyToAllPlayers: aBlock.
]
