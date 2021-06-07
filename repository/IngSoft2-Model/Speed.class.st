Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Speed >> actAt: aBoardGame on: aPlayer [
	aBoardGame apply: self on: aPlayer.
]

{ #category : #actions }
Speed >> action [
	^ 1.
]
