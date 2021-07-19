Class {
	#name : #Jail,
	#superclass : #Object,
	#instVars : [
		'fine',
		'dungeon'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
Jail class >> withFine: score [
	^self new initializeWithFine:score.
]

{ #category : #private }
Jail >> attempOfPayingFineWith: score of: player on: boardGame [
	fine = score
		ifTrue: [ self free: player with:score on: boardGame]
]

{ #category : #actions }
Jail >> free: player [
	dungeon remove: player
]

{ #category : #private }
Jail >> free: player with: score on: boardGame [
	boardGame free: player.
	boardGame enableMovementOf: player along: score
]

{ #category : #initialize }
Jail >> initializeWithFine: score [
	fine:= score.
	dungeon:=OrderedCollection new.
]

{ #category : #private }
Jail >> isAtTheDungeon: player [
	^ dungeon anySatisfy: [ :prisoner | prisoner = player ]
]

{ #category : #actions }
Jail >> throwToTheDungeon: player [
	dungeon add:player.
]

{ #category : #actions }
Jail >> trailOf: player withPayment: score on: boardGame [
	(self isAtTheDungeon: player)
		ifTrue: [ self attempOfPayingFineWith: score of: player on: boardGame]
		ifFalse: [  boardGame enableMovementOf: player along: score]
]
