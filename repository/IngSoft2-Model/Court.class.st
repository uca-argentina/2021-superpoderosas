Class {
	#name : #Court,
	#superclass : #Object,
	#instVars : [
		'dungeon',
		'penaltyFee'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
Court class >> dictating: penalty [
	^self new initializeDictating: penalty.
]

{ #category : #private }
Court >> attemptPayingPenaltyOf: player with: score on: boardGame [
	(self payPenaltyWith: score)
		ifTrue: [ boardGame free: player ].
	^ self payPenaltyWith: score
]

{ #category : #actions }
Court >> dictateIf: player isFreeWhenScored: score on: boardGame [ 
	(self isAtTheDungeon: player)
		ifTrue: [ ^ self attemptPayingPenaltyOf: player with: score on: boardGame]
		ifFalse: [ ^ true ]
]

{ #category : #actions }
Court >> free: player [
	dungeon remove: player
]

{ #category : #initialize }
Court >> initializeDictating: penalty [
	penaltyFee := penalty.
	dungeon:=OrderedCollection new.
]

{ #category : #private }
Court >> isAtTheDungeon: player [
	^ dungeon anySatisfy: [ :prisoner | prisoner = player ]
]

{ #category : #private }
Court >> payPenaltyWith: score [
	^ penaltyFee = score
]

{ #category : #actions }
Court >> throwToTheDungeon: player [
	dungeon add:player.
]
